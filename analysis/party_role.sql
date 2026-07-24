select  Case when Corp_ID is null then 'Individual Customer' end as role_type_code,
        '' as role_context_code,
        '' as context_reference_id,
        RELATIONSHIPOPENINGDATE as role_start_date,
        '' as role_end_date,
        Status as role_status_code,
        '' as is_primary,
         ORGKEY as source_party_id

from CRMUSER.ACCOUNTS 
where Entity_cre_flag = 'Y'
and corp_id is NULL

union all

select  Case when Corp_ID is not null then 'Corporate Customer' end as role_type_code,
        '' as role_context_code,
        '' as context_reference_id,
        relationship_StartDate as role_start_date,
        '' as role_end_date,
        Status as role_status_code,
        '' as is_primary,
         Corp_KEY as source_party_id

from CRMUSER.corporate
where ENTITY_CREATE_FLG = 'Y'