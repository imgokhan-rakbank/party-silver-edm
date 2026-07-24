CREATE TEMPORARY VIEW party_role_crmuser_accounts_staging AS
SELECT
  ORGKEY                  AS source_party_id,
  'Individual Customer'   AS role_type_code,
  ''                      AS role_context_code,
  ''                      AS context_reference_id,
  RELATIONSHIPOPENINGDATE AS role_start_date,
  ''                      AS role_end_date,
  Status                  AS role_status_code,
  ''                      AS is_primary,
  `__START_AT`,
  `__END_AT`
FROM STREAM(sandbox_dev.gokhani.crmuser_accounts_clean) WITH (SKIPCHANGECOMMITS)
WHERE Entity_cre_flag = 'Y'
  AND corp_id IS NULL;

CREATE TEMPORARY VIEW party_role_crmuser_corporate_staging AS
SELECT
  Corp_KEY               AS source_party_id,
  'Corporate Customer'   AS role_type_code,
  ''                     AS role_context_code,
  ''                     AS context_reference_id,
  relationship_StartDate AS role_start_date,
  ''                     AS role_end_date,
  Status                 AS role_status_code,
  ''                     AS is_primary,
  `__START_AT`,
  `__END_AT`
FROM STREAM(sandbox_dev.gokhani.crmuser_corporate_clean) WITH (SKIPCHANGECOMMITS)
WHERE ENTITY_CREATE_FLG = 'Y';
