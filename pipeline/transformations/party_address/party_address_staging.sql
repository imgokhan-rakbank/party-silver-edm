CREATE TEMPORARY VIEW party_address_analysis_staging AS
SELECT
  a.Orgkey AS CIF_ID,
  b.AddressCategory AS address_type_code,
  b.ADDRESS_LINE1 AS address_line_1,
  b.ADDRESS_LINE2 AS address_line_2,
  b.ADDRESS_LINE3 AS address_line_3,
  '' AS address_line_4,
  b.CITY,
  b.STATE AS state_province,
  b.ZIP AS Postal_Code,
  b.COUNTRY AS Country_Code,
  b.preferredAddress AS is_primary,
  '' AS is_verified,
  '' AS verification_date
FROM CRMUSER.ACCOUNTS a
INNER JOIN CRMUSER.ADDRESS b
  ON a.Orgkey = b.Orgkey
WHERE a.Entity_cre_flag = 'Y';
