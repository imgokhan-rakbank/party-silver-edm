from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party"
KEYS = ["CIF_ID"]
SOURCES = [
    {"source": "party_crmuser_accounts_staging", "name": "Accounts"},
    {"source": "party_crmuser_miscellaneousinfo_staging", "name": "GeneralInfo"},
    {"source": "party_crmuser_corporate_staging", "name": "Corporate"}
    ]

create_edm_master_flow(
    target = TARGET_TABLE,
    sources = SOURCES,
    keys = KEYS)
