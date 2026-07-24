select  a.Orgkey as CIF_ID,
        a.salutation_code as Title_Code,
        a.cust_first_name as First_Name,
        a.CUST_MIDDLE_NAME as Middle_Name,
        a.CUST_LAST_NAME as Last_Name,
        a.CUST_DOB as Birth_Date,
        b.Bank_Defined_Demo_var6 as Place_Of_Birth,
        b.Bank_Defined_Demo_var5 as Country_Of_Birth_Code,
        a.GENDER as Gender_Code,
        b.MARITAL_STATUS as Marital_Status_Code,
        a.MAIDENNAMEOFMOTHER as Mothers_Maiden_Name,
        c.userField7 as Residence_Ownership_Type_Code,
        d.NUMBEROFDEPENDANTS as Number_Of_Dependents,
        '' as Ethnicity_Code,
        e.strText25 as Education_Code,
        a.DATEUSERFIELD5 as Deceased_date,
        case when a.DATEUSERFIELD5 is not Null then 'Y' else 'N' end as Is_Deceased
    from CRMUSER.Accounts a 
    left join CRMUSER.Demographic b
    on a.Orgkey = b.Orgkey 
    left join (select * from CRMUSER.Address where AddressCategory = 'RESIDENCE') c 
    on a.Orgkey = c.Orgkey 
    left join CRMUSER.PSYCHOGRAPHIC d 
    on a.orgkey=d.orgkey
    left join (select * from CRMUSER.MiscellaneousInfo where TYPE = 'CURRENT_EMPLOYMENT') e 
    on a.orgkey=e.orgkey
    where a.ENTITY_CRE_FLAG ='Y'
  and a.corp_id is null