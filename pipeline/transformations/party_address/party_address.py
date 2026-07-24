from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_address"
KEYS = ["CIF_ID", "address_type_code", "address_line_1"]
SOURCES = [
    {"source": "party_address_analysis_staged", "name": "Analysis"}
]

create_edm_master_flow(
    target=TARGET_TABLE,
    sources=SOURCES,
    keys=KEYS)
