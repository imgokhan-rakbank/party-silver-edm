CREATE TEMPORARY VIEW party_crmuser_accounts_staging AS
SELECT
  ORGKEY                  AS CIF_ID,
  'INDIVIDUAL'            AS Party_Type_Code,
  NAME                    AS Full_Name,
  SHORT_NAME              AS SHORT_NAME,
  Status                  AS Party_Status_Code,
  RELATIONSHIPOPENINGDATE AS Party_Creation_Date,
  ''                      AS Party_End_Date,
  RELATIONSHIPOPENINGDATE AS Customer_Since_Date,
  'NA'                    AS Business_Line_Code,
  PRIMARY_SERVICE_CENTRE  AS Domicile_Branch_Code,
  PRIMARY_SOL_ID          AS Source_Branch_Code,
  Cust_commu_code         AS Is_Dormant,
  strField8               AS Is_Pre_Dormant,
  ''                      AS Has_SWIFT_Code,
  ''                      AS SWIFT_Code,
  'UAE'                   AS Country_Of_Domicile_Code,
  Constitution_Code       AS Inactivation_Reason_Code,
  StrUserField19          AS Overall_Blacklist_Status_Code,
  StrUserField17          AS Overall_Negation_Status_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_accounts) WITH (SKIPCHANGECOMMITS)
WHERE bank_id = 'RAK'
  AND ENTITY_CRE_FLAG = 'Y'
  AND corp_id IS NULL;

CREATE TEMPORARY VIEW party_crmuser_miscellaneousinfo_staging AS
SELECT
  ORGKEY   AS CIF_ID,
  STRTEXT5 AS Special_Status_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_miscellaneousinfo) WITH (SKIPCHANGECOMMITS)
WHERE TYPE = 'GENADD';

CREATE TEMPORARY VIEW party_crmuser_corporate_staging AS
SELECT
  corp_key               AS CIF_ID,
  'ORGANIZATION'         AS Party_Type_Code,
  corporate_Name         AS Full_Name,
  SHORT_NAME             AS SHORT_NAME,
  Status_desc            AS Party_Status_Code,
  'NA'                   AS Special_Status_Code,
  relationship_StartDate AS Party_Creation_Date,
  ''                     AS Party_End_Date,
  relationship_StartDate AS Customer_Since_Date,
  ''                     AS Business_Line_Code,
  StrUserField9          AS Domicile_Branch_Code,
  primary_Service_Center AS Source_Branch_Code,
  str5                   AS Is_Dormant,
  StrUserField5          AS Is_Pre_Dormant,
  ''                     AS Has_SWIFT_Code,
  ''                     AS SWIFT_Code,
  'UAE'                  AS Country_Of_Domicile_Code,
  REGION                 AS Inactivation_Reason_Code,
  StrUserField19         AS Overall_Blacklist_Status_Code,
  StrUserField17         AS Overall_Negation_Status_Code,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_corporate) WITH (SKIPCHANGECOMMITS)
WHERE ENTITY_CREATE_FLG = 'Y';
