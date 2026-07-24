from pyspark import pipelines as dp
from pyspark.sql import SparkSession,functions as F
from utilities.scd_utils import register_asynchronous_scd2_flow

import re
import importlib
import importlib.machinery
import importlib.util

spark = SparkSession.getActiveSession()

def create_edm_master_flow(
    target: str,
    sources: list,
    keys: list,
    snapshot: bool = True
):
    dp.create_streaming_table(name=target, cluster_by=keys)

    if snapshot:
        create_snapshot_view(target, keys)

    for source_entry in sources:
        register_asynchronous_scd2_flow(
            target = target,
            name = source_entry["name"],
            source = source_entry["source"],
            keys = source_entry.get("keys",keys)
        )

def create_snapshot_view(source: str, keys: list):
    """
    Declares a dynamic snapshot view using Databricks Lakeflow syntax.
    """
    # Generate dynamic view name matching the target table
    view_name = f"{source}_daily_snapshot"
    
    # 3. Use the Lakeflow view decorator dynamically
    @dp.view(name=view_name)
    def build_snapshot():
        # Read lazily from the pipeline's target table
        df = dp.read(source)
        
        # Build rolling 30-day date dimension frame 
        date_df = dp.spark.range(1).select(
            F.explode(
                F.sequence(
                    F.current_date() - F.expr("INTERVAL 30 DAY"), 
                    F.current_date(), 
                    F.expr("INTERVAL 1 DAY")
                )
            ).alias("snapshot_date")
        )
        
        # Parse Epoch millisecond bounds to standard Dates
        start_date_col = F.cast(F.from_unixtime(df["__START_AT"] / 1000), "date")
        end_date_col = F.cast(F.from_unixtime(df["__END_AT"] / 1000), "date")
        
        # Evaluate valid records for each date
        join_cond = (date_df["snapshot_date"] >= start_date_col) & (
            (date_df["snapshot_date"] < end_date_col) | df["__END_AT"].isNull()
        )
        
        # Apply composite window partition keys dynamically 
        partition_keys = ["snapshot_date"] + keys
        window_spec = Window.partitionBy(*[F.col(k) for k in partition_keys]).orderBy(df["__START_AT"].desc())
        
        # Construct and return the lineage DataFrame graph
        return (
            df.join(date_df, join_cond, "inner")
              .withColumn("_row_num", F.row_number().over(window_spec))
              .filter(F.col("_row_num") == 1)
              .drop("_row_num")
              .select("snapshot_date", df["*"])
        )