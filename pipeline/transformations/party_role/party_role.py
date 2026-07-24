from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_role"
KEYS = ["source_party_id", "role_type_code"]
SOURCES = [
    {"source": "party_role_analysis_staged", "name": "Analysis"}
]

create_edm_master_flow(
    target=TARGET_TABLE,
    sources=SOURCES,
    keys=KEYS)
