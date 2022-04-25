-- use maps_Reporting
--use maps

-- SELECT
--	COLUMN_NAME
--FROM
--  	INFORMATION_SCHEMA.COLUMNS
--WHERE
--	TABLE_NAME = 'Temp_GroupBenSys_before'

---------------------------------------------------------------------------------------
	Select abc.BenefitID
 AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())   
 --WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 WHERE YEAR(GP.EffectiveDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())   )  

 Select HearingLegalEntity
 YEAR(g.GroupEffDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())
 EXCEPT 
  Select HearingLegalEntity
 --into Temp_GroupPolicies_a1
 Select Count(*) from Temp_GroupPolicies_after 
    --where GroupEffDate NOT IN ('2020','2019','2018')

	Select * 
	
	 --from  Temp_GroupPolicies_after 
	 --where YEAR(GroupEffDate) NOT IN ('2020','2019','2018')
	from Temp_GroupPolicies_after where YEAR(GroupEffDate) NOT IN ('2020','2019','2018')
	EXCEPT 
	Select * from Temp_GroupPolicies_after 
 
 
-----------------------------------------------------------------------------------------------------
Print 'For Group Benefits'

Select 
PlanID
PlanID
  SELECT [IGPlan].GroupID,[IGPlan].PlanID,ipb.BenefitId 
  into #Temp_HospitalCopaytab
  FROM [IndividualGroupPlan] [IGPlan] WITH(NOLOCK)         
  LEFT JOIN IndividualPlanBenefit ipb WITH(NOLOCK) ON  [IGPlan].PlanId = ipb.PlanID        
  UNION        
  SELECT  GroupID,PlanID,BenefitId FROM [EmployerGroupPlanBenefit] [EGPlan] WITH(NOLOCK)        
 
SELECT BenefitId FROM #Temp_HospitalCopaytab abc  
inner join [Group] gp ON abc.GroupID = gp.GroupID where YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()))

  EXCEPT

  Select 
  BenefitID
from [Temp_HospitalCopay_after]
DROP table #Temp_HospitalCopaytab
---------------------------------------------------------------------------

---------------------------------------------------------------------------
PRINT 'FOR Temp_HospitalCopay_IDCARDELEMENTS'
 SELECT [IGPlan].GroupID,[IGPlan].PlanID,ipb.BenefitId 
		 into #HospitalCopayIDCardElement
		 FROM [IndividualGroupPlan] [IGPlan] WITH(NOLOCK)               
         LEFT JOIN IndividualPlanBenefit ipb WITH(NOLOCK) ON  [IGPlan].PlanId = ipb.PlanID              
         UNION              
         SELECT GroupID,PlanID,BenefitId FROM [EmployerGroupPlanBenefit] [EGPlan] WITH(NOLOCK)  

		Select 
		 BenefitID
		from [Temp_HospitalCopay_IDCardElements_before] where BenefitID IN ( 
SELECT BenefitId FROM #HospitalCopayIDCardElement abc  
inner join [Group] gp ON abc.GroupID = gp.GroupID where YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()))
EXCEPT 
Select 
BenefitID
from [Temp_HospitalCopay_IDCardElements_after]
DROP TABLE #HospitalCopayIDCardElement
---------------------------------------------------------------------------

PRINT 'For Temp_GroupBenefit'
Select 
from Temp_GroupBenefit_before abc inner join [Group] gp on gp.GroupID = abc.GroupID
Where YEAR(gp.EffectiveDate) IN (SELECT [Years] FROM dbo.udfGetPrevCurrNextYears())
EXCEPT 

Select 
from Temp_GroupBenefit_after
---------------------------------------------------------------------------------------
PRINT 'For Temp_GroupChangeCodes'
Select 
abc.GroupID,
GroupMoveFrom,
GroupMoveFromList,
DivisionMoveFrom,
ChangeCode
from Temp_GroupChangeCodes_before abc 
 INNER JOIN  [Group] gp  ON gp.GroupID = abc.GroupID
 where YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()) 
 EXCEPT 
 Select 
 GroupID,
GroupMoveFrom,
GroupMoveFromList,
DivisionMoveFrom,
ChangeCode
from Temp_GroupChangeCodes_after 
--------------------------------------------------------------------------
PRINT 'For [Temp_GroupBenSys]'

Select 

abc.GroupID
INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = abc.GroupId           
       WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')           
       AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())


	   EXCEPT 

	   Select 
	   GroupID
use maps


--Select top 10* from [Temp_GroupCountiesRPT](nolock)

Select gp.GroupNumber, gp.TerminationDate,gp.EffectiveDate from Temp_GroupPolicies(nolock) abc 
inner join [Group](nolock) gp on gp.GroupID = abc.GroupID 
WHERE abc.GroupEffDate = IsNull(GP.TerminationDate,'9999-12-31')

Select * from [dbo].Temp_GroupPolicies(nolock)  

--1442

Select * from [Temp_GroupCountiesRPTSGE](nolock) order by 1 desc abc INNER JOIN [Group](nolock) GP on GP.GroupID = abc.GroupID 
WHERE GP.EffectiveDate = IsNull(GP.TerminationDate,'9999-12-31')     
AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())      

Select Count(*) from BatchExtractLog(nolock) where JobName like 'Extract Group Template Prod New Format'  and Year(ExtractDate) IN ('2017','2018','2019','2020') order by 1 desc   
     
	 
SELECT *, COUNT(*) as cnt
FROM [Temp_GroupBenefit](nolock) abc INNER JOIN [Group](nolock) GP on GP.GroupID = abc.GroupID 
WHERE GP.EffectiveDate = IsNull(GP.TerminationDate,'9999-12-31')     
AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())          
   GROUP BY PlanID
HAVING COUNT(*) > 1








SELECT PlanID,
CMSStateCode,
State,
CountyNameList,
CountyList , CreateDate, COUNT(*) as cnt
FROM [Temp_GroupCountiesRPT](nolock) 
where Year(CreateDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]() )
 
CMSStateCode,
State,r
CountyNameList,
CountyList
HAVING COUNT(*) > 1 order by CreateDate desc

Select top 1000 * from [Temp_GroupCountiesRPT](nolock) where Year(CreateDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]() ) order by 1 desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------