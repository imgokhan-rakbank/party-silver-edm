select a.Orgkey as CIF_ID,
        b.PhoneEmailType as contact_type_code,
        Coalesce(b.PhoneNo, b.Email, b.URL) as Contact_Value,
        b.PHONENOCOUNTRYCODE as country_dialing_code,
        b.WORKEXTENSION as extension_number,
        '' as is_primary,
        b.PREFERREDFLAG as is_preferred,
        '' as do_not_contact,
        '' as is_verified,
        '' as verification_date
from crmuser.accounts a
inner join crmuser.PhoneEmail b
on a.Orgkey = b.Orgkey
where a.Entity_cre_flag = 'Y'
and a.corp_id is NULL