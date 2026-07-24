select a.Orgkey as CIF_ID,
        b.AddressCategory as address_type_code,
        b.ADDRESS_LINE1 as address_line_1,
        b.ADDRESS_LINE2 as address_line_2,
        b.ADDRESS_LINE3 as address_line_3,
        '' as address_line_4,
        b.CITY,
        b.STATE as state_province,
        b.ZIP as Postal_Code,
        b.COUNTRY as Country_Code,
        b.preferredAddress as is_primary,
        '' as is_verified,
        '' as verification_date
from CRMUSER.ACCOUNTS  a
inner join CRMUSER.ADDRESS b
on a.Orgkey = b.Orgkey
where a.Entity_cre_flag = 'Y'
