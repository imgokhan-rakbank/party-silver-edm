CREATE TEMPORARY VIEW party_address_crmuser_address_staging AS
SELECT
  b.ORGKEY         AS CIF_ID,
  b.AddressCategory AS address_type_code,
  b.ADDRESS_LINE1  AS address_line_1,
  b.ADDRESS_LINE2  AS address_line_2,
  b.ADDRESS_LINE3  AS address_line_3,
  ''               AS address_line_4,
  b.CITY           AS CITY,
  b.STATE          AS state_province,
  b.ZIP            AS Postal_Code,
  b.COUNTRY        AS Country_Code,
  b.preferredAddress AS is_primary,
  ''               AS is_verified,
  ''               AS verification_date,
  `__START_AT`,
  `__END_AT`
FROM STREAM(${source_catalog}.finacle.crmuser_address) WITH (SKIPCHANGECOMMITS) b
INNER JOIN ${source_catalog}.finacle.crmuser_accounts a
  ON b.ORGKEY = a.ORGKEY
 AND a.Entity_cre_flag = 'Y';
