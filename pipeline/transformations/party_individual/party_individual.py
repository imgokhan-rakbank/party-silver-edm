from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utilities.silver import create_edm_master_flow

TARGET_TABLE = "party_individual"
KEYS = ["CIF_ID"]
SOURCES = [
    {"source": "party_individual_crmuser_accounts_staging", "name": "Accounts"},
    {"source": "party_individual_crmuser_demographic_staging", "name": "Demographic"},
    {"source": "party_individual_crmuser_address_staging", "name": "Address"},
    {"source": "party_individual_crmuser_psychographic_staging", "name": "Psychographic"},
    {"source": "party_individual_crmuser_miscellaneousinfo_staging", "name": "Employment"}
    ]

create_edm_master_flow(
    target = TARGET_TABLE,
    sources = SOURCES,
    keys = KEYS)
