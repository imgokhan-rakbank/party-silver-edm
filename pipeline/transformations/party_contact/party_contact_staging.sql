CREATE TEMPORARY VIEW party_contact_analysis_staging AS
SELECT
  a.Orgkey AS CIF_ID,
  b.PhoneEmailType AS contact_type_code,
  COALESCE(b.PhoneNo, b.Email, b.URL) AS Contact_Value,
  b.PHONENOCOUNTRYCODE AS country_dialing_code,
  b.WORKEXTENSION AS extension_number,
  '' AS is_primary,
  b.PREFERREDFLAG AS is_preferred,
  '' AS do_not_contact,
  '' AS is_verified,
  '' AS verification_date
FROM crmuser.accounts a
INNER JOIN crmuser.PhoneEmail b
  ON a.Orgkey = b.Orgkey
WHERE a.Entity_cre_flag = 'Y'
  AND a.corp_id IS NULL;
