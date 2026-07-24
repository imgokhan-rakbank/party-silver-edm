CREATE TEMPORARY VIEW party_individual_crmuser_accounts_staging AS
SELECT
  ORGKEY            AS CIF_ID,
  cust_first_name   AS First_Name,
  CUST_MIDDLE_NAME  AS Middle_Name,
  CUST_LAST_NAME    AS Last_Name,
  `__START_AT`,
  `__END_AT`
FROM STREAM(sandbox_dev.gokhani.crmuser_accounts_clean) WITH (SKIPCHANGECOMMITS)
WHERE CORP_ID IS NULL;

CREATE TEMPORARY VIEW party_individual_crmuser_demographic_staging AS
SELECT
  cd.ORGKEY                   AS CIF_ID,
  cd.Bank_Defined_Demo_var6   AS Place_Of_Birth,
  CASE
    WHEN cd.Bank_Defined_Demo_var5 IS NULL THEN NULL
    WHEN rc.country_code IS NOT NULL THEN cd.Bank_Defined_Demo_var5
    ELSE 'INVALID'
  END                         AS Country_Of_Birth_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(sandbox_dev.gokhani.crmuser_demographic_clean) WITH (SKIPCHANGECOMMITS) cd
LEFT JOIN sandbox_dev.gokhani.reference_country rc
  ON cd.Bank_Defined_Demo_var5 = rc.country_code;