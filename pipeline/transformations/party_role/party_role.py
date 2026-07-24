from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_role"
KEYS = ["source_party_id"]
SOURCES = [
    {"source": "party_role_crmuser_accounts_staging", "name": "Accounts"},
    {"source": "party_role_crmuser_corporate_staging", "name": "Corporate"}
    ]

create_edm_master_flow(
    target = TARGET_TABLE,
    sources = SOURCES,
    keys = KEYS)
