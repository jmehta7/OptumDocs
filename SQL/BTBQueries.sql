use btb
Select top 10 * from [CS].[Users]
ProductId - 14523678
BTB Product ID = 10069
BTB GroupID = 10015 -
--ProductID = Fieldvalue in dynamicfieldvalues table = 

--BTB GroupID = 10015 from plan table
Select top 50 * from CS.PLANS order by 1 desc

Select top 500 * from CS.dynamicfieldvalues  where FieldID = 17 and FieldValue = '2311' order by 1 asc
Product ID  = 39393939
Sub Group ID = 2311
 SELECT a.FieldValue, a.planid, a.membergroupid  FROM  [CS].[dynamicfieldvalues]  a 
                                     WHERE  a.FieldID = 17 and a.FieldValue like 9999 

									 SELECT DISTINCT a.planid, a.membergroupid  
                                     FROM  [CS].[dynamicfieldvalues]  a 
                                     WHERE  a.FieldID = 17 and a.FieldValue like {3}

Select *  from [CS].[PLANS] as a 
inner join [CS].[DynamicFieldValues] as b
ON a.MemberGroupID = b.MemberGroupID where
 b.PlanID = -1 and  b.FieldID = 4 and b.[FieldValue] like '9999'


 select * from [CS].MemberGroups a
INNER JOIN [CS].Customers b 
ON b.CustomerID = a.CustomerID
INNER JOIN [CS].[Plans] c  
ON  a.MemberGroupID = c.MemberGroupID 

Select u.LastName , (u.Firstname + ' - ' + u.LoginName) as CMOwner from CS.Users u


select  distinct c.planid, c.membergroupid  from [CS].MemberGroups a ,[CS].Customers b,[CS].Plans c  
 where  b.CustomerID = a.CustomerID and a.MemberGroupID = c.MemberGroupID 


 Select top 10 * from [CS].dynamicfieldvalues where FieldID = 16 and FieldValue = '14523678' order by  1 desc
 Select top 10 * from [CS].dynamicfieldvalues where FieldID = 17 and FieldValue = '1245' order by  1 desc




 use btb
Select cust.Name, mp.RwID,mp.RowLabel,CSPProductDesc,gv.* from CS.GppMedCostShareGridValues  gv
inner join CS.MemberGroupCSPProducts cs 
ON cs.CSPProductID = gv.CSPProductID 
inner join CS.GppMedCostShareRowMapping mp
ON mp.RwID = gv.RwID
inner join CS.MemberGroups mg on mg.MemberGroupID = gv.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
where 
mp.RwID IN( 4) and
--cs.CSPProductDesc = 'CSGWA000 - WA Cascade Select GOLD D500/1000 O5250/10500 PC20'
--and
 gv.MemberGroupID IN ( 40308,40313,40314,40315,40316,40317,40318,40319,40320,40321,40322,40323,40324,40325,40326)
 --order by cs.CSPProductID asc



 
use btb
Select DISTINCT gv.Covered,cust.Name, gv.* from CS.GppMedCostShareGridValues(nolock)  gv
inner join CS.MemberGroupCSPProducts cs 
ON cs.CSPProductID = gv.CSPProductID 
inner join CS.GppMedCostShareRowMapping mp
ON mp.RwID = gv.RwID
inner join CS.MemberGroups mg on mg.MemberGroupID = gv.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
where 
mp.RwID IN(98) and
--cs.CSPProductDesc = 'CSGWA000 - WA Cascade Select GOLD D500/1000 O5250/10500 PC20'
--and
 gv.MemberGroupID IN (40326) and cs.CSPProductID IN( 232,253,254) and gv.PlanID = 40690
 ( 40308,40313,40314,40315,40316,40317,40318,40319,40320,40321,40322,40323,40324,40325,40326)
 --and  gv.Covered = NULL 


 --order by cs.CSPProductID asc

 use btb
 Select * from CS.GppMedCostShareRowMapping where RowLabel = 'Vendor Virtual Care PCP Services (Visits 1-3)' order by 1 asc

 -----------------------

 
 --Deductible in Med Ben Cost Share
	  
Select cust.Name as HealthPlan,MGV.MemberGroupID, MGV.PlanID, MGV.CSPProductID,cs.CSPProductDesc, MGV.RwID,mp.RowLabel,
MGV.DoesDeductibleApply,GV.DoesDeductibleApply as ExcelDed FROM CS.GppMedCostShareGridValues MGV 
Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
inner join CS.MemberGroups mg on mg.MemberGroupID = MGV.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
inner join CS.GppMedCostShareRowMapping mp ON mp.RwID = MGV.RwID
inner join CS.MemberGroupCSPProducts cs ON cs.CSPProductID = MGV.CSPProductID 
and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and MGV.DoesDeductibleApply <> GV.DoesDeductibleApply
order by GV.RwID asc

---------------