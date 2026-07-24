select  a.ORGKEY as CIF_ID ,
        'INDIVIDUAL' as Party_Type_Code,
        a.NAME as Full_Name,
        a.SHORT_NAME,
        a.Status as Party_Status_Code,
        b.STRTEXT5 as Special_Status_Code,
        a.RELATIONSHIPOPENINGDATE as Party_Creation_Date,
        '' as Party_End_Date,
        a.RELATIONSHIPOPENINGDATE as Customer_Since_Date,
        'NA' as Business_Line_Code,
        a.PRIMARY_SERVICE_CENTRE as Domicile_Branch_Code,
        a.PRIMARY_SOL_ID as Source_Branch_Code,
        a.Cust_commu_code as Is_Dormant,
        a.strField8 as Is_Pre_Dormant ,
        '' as Has_SWIFT_Code,
        '' as SWIFT_Code,
        'UAE' as Country_Of_Domicile_Code,
        a.Constitution_Code as Inactivation_Reason_Code,
        a.StrUserField19 as Overall_Blacklist_Status_Code,
        a.StrUserField17 as Overall_Negation_Status_Code 
  from CRMUSER.ACCOUNTS a 
  left join CRMUSER.miscellaneousinfo b 
      on a.Orgkey = b.Orgkey
  where b.TYPE = 'GENADD' 
  and a.bank_id='RAK'
  and a.ENTITY_CRE_FLAG ='Y'
  and a.corp_id is null

  UNION ALL

  select  a.corp_key as CIF_ID,
        'ORGANIZATION' as Party_Type_Code,
        a.corporate_Name as Full_Name,
        a.SHORT_NAME,
        a.Status_desc as Party_Status_Code,
        'NA' as Special_Status_Code,
        a.relationship_StartDate as Party_Creation_Date,
        '' as Party_End_Date,
        a.relationship_StartDate as Customer_Since_Date,
        '' as Business_Line_Code,
        a.StrUserField9 as Domicile_Branch_Code,
        a.primary_Service_Center as Source_Branch_Code,
        a.str5 as Is_Dormant,
        a.StrUserField5 as Is_Pre_Dormant,
        '' as Has_SWIFT_Code,
        '' as SWIFT_Code,
        'UAE' as Country_Of_Domicile_Code,
        a.REGION as Inactivation_Reason_Code,
        a.StrUserField19 as Overall_Blacklist_Status_Code,
        a.StrUserField17 as Overall_Negation_Status_Code 
from CRMUSER.corporate a
where ENTITY_CREATE_FLG = 'Y'