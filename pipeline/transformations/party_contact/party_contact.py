from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_contact"
KEYS = ["CIF_ID", "contact_type_code", "Contact_Value"]
SOURCES = [
    {"source": "party_contact_analysis_staged", "name": "Analysis"}
]

create_edm_master_flow(
    target=TARGET_TABLE,
    sources=SOURCES,
    keys=KEYS)
