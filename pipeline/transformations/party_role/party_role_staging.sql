CREATE TEMPORARY VIEW party_role_analysis_staging AS
SELECT
  CASE
    WHEN Corp_ID IS NULL THEN 'Individual Customer'
  END AS role_type_code,
  '' AS role_context_code,
  '' AS context_reference_id,
  RELATIONSHIPOPENINGDATE AS role_start_date,
  '' AS role_end_date,
  Status AS role_status_code,
  '' AS is_primary,
  ORGKEY AS source_party_id
FROM CRMUSER.ACCOUNTS
WHERE Entity_cre_flag = 'Y'
  AND corp_id IS NULL

UNION ALL

SELECT
  CASE
    WHEN Corp_ID IS NOT NULL THEN 'Corporate Customer'
  END AS role_type_code,
  '' AS role_context_code,
  '' AS context_reference_id,
  relationship_StartDate AS role_start_date,
  '' AS role_end_date,
  Status AS role_status_code,
  '' AS is_primary,
  Corp_KEY AS source_party_id
FROM CRMUSER.corporate
WHERE ENTITY_CREATE_FLG = 'Y';
