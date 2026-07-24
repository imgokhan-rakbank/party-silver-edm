CREATE TEMPORARY VIEW party_individual_crmuser_accounts_staging AS
SELECT
  ORGKEY              AS CIF_ID,
  salutation_code     AS Title_Code,
  cust_first_name     AS First_Name,
  CUST_MIDDLE_NAME    AS Middle_Name,
  CUST_LAST_NAME      AS Last_Name,
  CUST_DOB            AS Birth_Date,
  GENDER              AS Gender_Code,
  MAIDENNAMEOFMOTHER  AS Mothers_Maiden_Name,
  ''                  AS Ethnicity_Code,
  DATEUSERFIELD5      AS Deceased_date,
  CASE WHEN DATEUSERFIELD5 IS NOT NULL THEN 'Y' ELSE 'N' END AS Is_Deceased,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_accounts) WITH (SKIPCHANGECOMMITS)
WHERE ENTITY_CRE_FLAG = 'Y'
  AND CORP_ID IS NULL;

CREATE TEMPORARY VIEW party_individual_crmuser_demographic_staging AS
SELECT
  cd.ORGKEY                   AS CIF_ID,
  cd.Bank_Defined_Demo_var6   AS Place_Of_Birth,
  CASE
    WHEN cd.Bank_Defined_Demo_var5 IS NULL THEN NULL
    WHEN rc.country_code IS NOT NULL THEN cd.Bank_Defined_Demo_var5
    ELSE 'INVALID'
  END                         AS Country_Of_Birth_Code,
  cd.MARITAL_STATUS           AS Marital_Status_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_demographic) WITH (SKIPCHANGECOMMITS) cd
LEFT JOIN ${source_catalog}.gokhani.reference_country rc
  ON cd.Bank_Defined_Demo_var5 = rc.country_code;

CREATE TEMPORARY VIEW party_individual_crmuser_address_staging AS
SELECT
  ORGKEY     AS CIF_ID,
  userField7 AS Residence_Ownership_Type_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_address) WITH (SKIPCHANGECOMMITS)
WHERE AddressCategory = 'RESIDENCE';

CREATE TEMPORARY VIEW party_individual_crmuser_psychographic_staging AS
SELECT
  ORGKEY            AS CIF_ID,
  NUMBEROFDEPENDANTS AS Number_Of_Dependents,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_psychographic) WITH (SKIPCHANGECOMMITS);

CREATE TEMPORARY VIEW party_individual_crmuser_miscellaneousinfo_staging AS
SELECT
  ORGKEY    AS CIF_ID,
  strText25 AS Education_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_miscellaneousinfo) WITH (SKIPCHANGECOMMITS)
WHERE TYPE = 'CURRENT_EMPLOYMENT';
