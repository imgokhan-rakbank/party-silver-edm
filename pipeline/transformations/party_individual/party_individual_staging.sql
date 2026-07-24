CREATE TEMPORARY VIEW party_individual_analysis_staging AS
SELECT
  a.Orgkey AS CIF_ID,
  a.salutation_code AS Title_Code,
  a.cust_first_name AS First_Name,
  a.CUST_MIDDLE_NAME AS Middle_Name,
  a.CUST_LAST_NAME AS Last_Name,
  a.CUST_DOB AS Birth_Date,
  b.Bank_Defined_Demo_var6 AS Place_Of_Birth,
  b.Bank_Defined_Demo_var5 AS Country_Of_Birth_Code,
  a.GENDER AS Gender_Code,
  b.MARITAL_STATUS AS Marital_Status_Code,
  a.MAIDENNAMEOFMOTHER AS Mothers_Maiden_Name,
  c.userField7 AS Residence_Ownership_Type_Code,
  d.NUMBEROFDEPENDANTS AS Number_Of_Dependents,
  '' AS Ethnicity_Code,
  e.strText25 AS Education_Code,
  a.DATEUSERFIELD5 AS Deceased_date,
  CASE
    WHEN a.DATEUSERFIELD5 IS NOT NULL THEN 'Y'
    ELSE 'N'
  END AS Is_Deceased
FROM CRMUSER.Accounts a
LEFT JOIN CRMUSER.Demographic b
  ON a.Orgkey = b.Orgkey
LEFT JOIN (
  SELECT *
  FROM CRMUSER.Address
  WHERE AddressCategory = 'RESIDENCE'
) c
  ON a.Orgkey = c.Orgkey
LEFT JOIN CRMUSER.PSYCHOGRAPHIC d
  ON a.orgkey = d.orgkey
LEFT JOIN (
  SELECT *
  FROM CRMUSER.MiscellaneousInfo
  WHERE TYPE = 'CURRENT_EMPLOYMENT'
) e
  ON a.orgkey = e.orgkey
WHERE a.ENTITY_CRE_FLAG = 'Y'
  AND a.corp_id IS NULL;
