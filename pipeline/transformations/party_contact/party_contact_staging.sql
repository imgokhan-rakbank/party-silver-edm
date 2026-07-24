CREATE TEMPORARY VIEW party_contact_crmuser_phoneemail_staging AS
SELECT
  b.ORGKEY          AS CIF_ID,
  b.PhoneEmailType  AS contact_type_code,
  COALESCE(b.PhoneNo, b.Email, b.URL) AS Contact_Value,
  b.PHONENOCOUNTRYCODE AS country_dialing_code,
  b.WORKEXTENSION   AS extension_number,
  ''                AS is_primary,
  b.PREFERREDFLAG   AS is_preferred,
  ''                AS do_not_contact,
  ''                AS is_verified,
  ''                AS verification_date,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_phoneemail) WITH (SKIPCHANGECOMMITS) b
INNER JOIN ${source_catalog}.finacle.crmuser_accounts a
  ON b.ORGKEY = a.ORGKEY
 AND a.Entity_cre_flag = 'Y'
 AND a.corp_id IS NULL;
