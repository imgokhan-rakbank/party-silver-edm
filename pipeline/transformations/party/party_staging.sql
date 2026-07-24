CREATE TEMPORARY VIEW party_analysis_staging AS
SELECT
  a.ORGKEY AS CIF_ID,
  'INDIVIDUAL' AS Party_Type_Code,
  a.NAME AS Full_Name,
  a.SHORT_NAME,
  a.Status AS Party_Status_Code,
  b.STRTEXT5 AS Special_Status_Code,
  a.RELATIONSHIPOPENINGDATE AS Party_Creation_Date,
  '' AS Party_End_Date,
  a.RELATIONSHIPOPENINGDATE AS Customer_Since_Date,
  'NA' AS Business_Line_Code,
  a.PRIMARY_SERVICE_CENTRE AS Domicile_Branch_Code,
  a.PRIMARY_SOL_ID AS Source_Branch_Code,
  a.Cust_commu_code AS Is_Dormant,
  a.strField8 AS Is_Pre_Dormant,
  '' AS Has_SWIFT_Code,
  '' AS SWIFT_Code,
  'UAE' AS Country_Of_Domicile_Code,
  a.Constitution_Code AS Inactivation_Reason_Code,
  a.StrUserField19 AS Overall_Blacklist_Status_Code,
  a.StrUserField17 AS Overall_Negation_Status_Code
FROM CRMUSER.ACCOUNTS a
LEFT JOIN CRMUSER.miscellaneousinfo b
  ON a.Orgkey = b.Orgkey
WHERE b.TYPE = 'GENADD'
  AND a.bank_id = 'RAK'
  AND a.ENTITY_CRE_FLAG = 'Y'
  AND a.corp_id IS NULL

UNION ALL

SELECT
  a.corp_key AS CIF_ID,
  'ORGANIZATION' AS Party_Type_Code,
  a.corporate_Name AS Full_Name,
  a.SHORT_NAME,
  a.Status_desc AS Party_Status_Code,
  'NA' AS Special_Status_Code,
  a.relationship_StartDate AS Party_Creation_Date,
  '' AS Party_End_Date,
  a.relationship_StartDate AS Customer_Since_Date,
  '' AS Business_Line_Code,
  a.StrUserField9 AS Domicile_Branch_Code,
  a.primary_Service_Center AS Source_Branch_Code,
  a.str5 AS Is_Dormant,
  a.StrUserField5 AS Is_Pre_Dormant,
  '' AS Has_SWIFT_Code,
  '' AS SWIFT_Code,
  'UAE' AS Country_Of_Domicile_Code,
  a.REGION AS Inactivation_Reason_Code,
  a.StrUserField19 AS Overall_Blacklist_Status_Code,
  a.StrUserField17 AS Overall_Negation_Status_Code
FROM CRMUSER.corporate a
WHERE ENTITY_CREATE_FLG = 'Y';
