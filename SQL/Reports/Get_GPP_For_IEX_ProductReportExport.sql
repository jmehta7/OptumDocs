USE [BTB]
GO
/****** Object:  StoredProcedure [CS].[Get_GPP_For_IEX_ProductReportExport]    Script Date: 7/23/2021 6:34:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Vandana
-- Create date: 14/07/2021
-- Description: For IEX ProductInfoExport Report - GPP tab  
-- =============================================
ALTER proc [CS].[Get_GPP_For_IEX_ProductReportExport]      
(@MemberGroupID int,      
@Planid int) 
/*
  [CS].[Get_GPP_For_ProductReportExport] 2, 2
  --, '9,10,11,12,13'

  --[CS].Get_RPT_Product 2,2,'5,6,7'      

  select * from cs.plans where planid=3  
  Select * From [CS].[GPPCopayGridValues] Where PlanId=2 and MemberGroupId=2
*/     
as       
BEGIN  
    
	declare @Dynamictbl table  
	(rowNo int Identity(1,1),
	MemberGroupID int,
	PlanId int,
	FieldID int,  
	TableName varchar(max),  
	Network varchar(max) null,
	GridRwID int default(0),
	LabelName varchar(max),  
	FieldValue1 varchar(max),  
	FieldValue2 varchar(max),  
	FieldValue3 varchar(max),  
	FieldValue4 varchar(max))  
  



	--GPP - Deduct

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, 0,TableName,'Header',0,'General Product Provisions - Deductible',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=5  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Does  this product have any Deductibles?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=5  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Are the Med/Rx Deductibles Combined?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=6  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Does this product have an out - of pocket max?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=7  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Are INN & OON OOP Max combined?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=8  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Does this product have lifetime maximums?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=9  

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, 44,'GPPDedOOPGridHeaders','INN',0,null,'Amount', 'Comments', Null, Null 

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, 44, 'GPPDedOOPGridValues',
	Network,
	gcr.RwID,
	RowLabel,
	case 
	   when Amount is not null then '$'+ cast(Amount as varchar)
	   else cast(Amount as varchar)
	   end Amount,
	Comments,Null, Null 
	from [CS].[GPPDedOOPGridMapping] gcr with(nolock)
	left join [CS].[GPPDedOOPGridValues] gcgv with(nolock) on gcr.rwid=gcgv.rwid
	and gcgv.MemberGroupID=@MemberGroupID and gcgv.PlanID=@Planid
	Where Network = 'INN'
	order by OrderNum

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Are amounts different for out- of network?',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=10

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, 44,'GPPDedOOPGridHeaders','OON',0,null,'Amount', 'Comments', Null, Null

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, 44, 'GPPDedOOPGridValues',
	Network,
	gcr.RwID,
	RowLabel,
	case 
	   when Amount is not null then '$'+ cast(Amount as varchar)
	   else cast(Amount as varchar)
	   end Amount,
	Comments,Null, Null 
	from [CS].[GPPDedOOPGridMapping] gcr with(nolock)
	left join [CS].[GPPDedOOPGridValues] gcgv with(nolock) on gcr.rwid=gcgv.rwid
	and gcgv.MemberGroupID=@MemberGroupID and gcgv.PlanID=@Planid
	Where Network = 'OON'
	order by OrderNum

	

	insert into @Dynamictbl  
	select @MemberGroupID, @Planid, FieldID,TableName,null,0,'Deductible Comments:',Null, Null, Null, Null from CS.NonDynamicFieldDefs df   
	where TableName ='GPPDedOOPMValues' and FieldID=11

	update @Dynamictbl set FieldValue1= CASE WHEN d.FieldID = 5 THEN (select ValidValueText from cs.validvalues where ValidValueID=DoesThisProdHaveDed)
											When d.FieldID = 6 THEN (select ValidValueText from cs.validvalues where ValidValueID=AreMedRxDedCombined)
											When d.FieldID = 7 THEN (select ValidValueText from cs.validvalues where ValidValueID=DoesThisProdHaveOOPMax)
											When d.FieldID = 8 THEN (select ValidValueText from cs.validvalues where ValidValueID=AreINNOONMaxCombined)
											When d.FieldID = 9 THEN (select ValidValueText from cs.validvalues where ValidValueID=DoesThisProdHaveLifeMax)
											When d.FieldID = 10 THEN (select ValidValueText from cs.validvalues where ValidValueID=AreAmountsDiffForOON)
											When d.FieldID = 11 THEN DedComments
										END
	from [CS].GPPDedOOPMValues gcv with(nolock)--GPPDedOOPMValues
	join @Dynamictbl d on d.MemberGroupID=gcv.MemberGroupID and d.PlanID=gcv.PlanID
	where gcv.MemberGroupID=@MemberGroupID and gcv.PlanID=@PlanID
	And d.FieldID in (5,6,7,8,9,10,11) 

	Delete From @Dynamictbl Where FieldId in (6, 44) AND GridRwID in (0, 2,6) AND TableName <> 'GPPDedOOPGridHeaders'	--Delete OOP Max from GPPDed Grid if it is set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND FieldValue1='Yes, Medical Only')

	Delete From @Dynamictbl Where FieldId in (6, 44) AND GridRwID in (0, 1,5) AND TableName <> 'GPPDedOOPGridHeaders'	--Delete OOP Max from GPPDed Grid if it is set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND FieldValue1='Yes, Pharmacy Only')

	Delete From @Dynamictbl Where FieldId in (8, 44) AND GridRwID in (0, 3,7) AND TableName <> 'GPPDedOOPGridHeaders'	--Delete OOP Max from GPPDed Grid if it is set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=7 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 

	Delete From @Dynamictbl Where FieldId = 44 AND GridRwID in (4,8)	--Delete Lifetime Max from GPPDed Grid if it is set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=9 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 


	Delete From @Dynamictbl
	Where FieldId in (6,8,44) 	--Delete Complete GPPDed Grid if it has set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=7 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=9 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND (TableName = 'GPPDedOOPMValues' OR TableName = 'GPPDedOOPGridValues' OR TableName = 'GPPDedOOPGridHeaders')

	Delete From @Dynamictbl
	Where FieldId in (6,44) AND GridRwID in (0,1,2,4,5,6,8) 	--Delete from GPPDed based on OOP Max flag
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=7 AND FieldValue1='Yes') 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=9 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND (TableName = 'GPPDedOOPMValues' OR TableName = 'GPPDedOOPGridValues')

	Delete From @Dynamictbl
	Where FieldId in (6,8,44) AND GridRwID in (0,1,2,3,5,6,7) 	--Delete from GPPDed based on lifetime flag
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=7 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=9 AND FieldValue1='Yes') 
	AND (TableName = 'GPPDedOOPMValues' OR TableName = 'GPPDedOOPGridValues')

	Delete From @Dynamictbl
	Where FieldId in (6,8,44) AND GridRwID in (0,1,2,5,6) 	--Delete from GPPDed based on both OOP max and lifetime flag
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=5 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=7 AND FieldValue1='Yes') 
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=9 AND FieldValue1='Yes') 
	AND (TableName = 'GPPDedOOPMValues' OR TableName = 'GPPDedOOPGridValues')
		
	Delete From @Dynamictbl
	Where FieldId = 44 AND Network = 'OON' 	--Delete from GPPDed based on both OOP max and lifetime flag
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=10 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	AND (TableName = 'GPPDedOOPGridValues' OR TableName = 'GPPDedOOPGridHeaders')

	Delete From @Dynamictbl
	Where FieldId in (1078,1079)	--Delete Goldstar / Preferred Provider Program General columns if it has set as no
	AND Exists (Select FieldID From @Dynamictbl Where FieldID=1077 AND (FieldValue1='No' OR FieldValue1='[Select One]')) 
	
	select * from @Dynamictbl order by rowNo   

END