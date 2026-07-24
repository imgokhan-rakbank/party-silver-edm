import re
from pyspark import pipelines as dp
from pyspark.sql import SparkSession,functions as F

spark = SparkSession.getActiveSession()

def register_asynchronous_scd2_flow(
    target: str,
    name: str,
    source: str,
    keys: list,
    stored_as_scd_type: str = "2",
):
    @dp.temporary_view(name=f"{source}_wrapped")
    def wrapped_view():
        return (
            spark.readStream.table(source)
            .withColumnRenamed("__START_AT", f"__{name}_START_AT")
            .withColumnRenamed("__END_AT", f"__{name}_END_AT")
        )

    dp.create_auto_cdc_flow(
        target = target,
        source = f"{source}_wrapped",
        keys = keys,
        sequence_by = f"__{name}_START_AT",
        stored_as_scd_type = stored_as_scd_type,
        track_history_except_column_list = [f"__{name}_START_AT", f"__{name}_END_AT"], 
        name = f"{re.sub(r'[^a-zA-Z0-9_]', '_', target)}_{re.sub(r'[^a-zA-Z0-9_]', '_', source)}_flow", 
        )