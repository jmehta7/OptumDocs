 SELECT
	COLUMN_NAME
FROM
  	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'Temp_GroupBenefit'


	--where Year(gp.GroupEffectiveDate) IN ('2019','2018','2020')


	Select abc.BenefitID
--DELETE FROM [dbo].[Temp_GroupBenefit]    
--			Where GroupID IN (Select TG.GroupID from  [dbo].[Temp_GroupBenefit]  TG
--			INNER JOIN [Group] gp ON  gp.GroupID = TG.GroupID  
--			where YEAR(gp.EffectiveDate ) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()) )


Select 
PlanID
PlanID