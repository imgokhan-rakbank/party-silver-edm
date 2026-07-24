from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_individual"
KEYS = ["CIF_ID"]
SOURCES = [
    {"source": "party_individual_analysis_staged", "name": "Analysis"}
]

create_edm_master_flow(
    target=TARGET_TABLE,
    sources=SOURCES,
    keys=KEYS)
