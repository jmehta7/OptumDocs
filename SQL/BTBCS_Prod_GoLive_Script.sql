USE [BTB]
GO
/****** Object:  UserDefinedFunction [CS].[KeywordDateMatch]    Script Date: 7/27/2021 7:57:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [CS].[KeywordDateMatch] (@keyword VARCHAR(max), @comparetext varchar(max), @matchwholeword bit)
RETURNS bit
AS BEGIN
    DECLARE @Result bit
	DECLARE @comparedate date = null

	if isdate(@comparetext) = 1
	SET @comparedate = cast(@comparetext as date)
	
	if @comparedate is null
	SET @Result = 0
	ELSE
	if @matchwholeword = 1
	SET @Result = (select count(*) from (select 1 as matched where convert(varchar(max),@comparedate,101) like '%[^a-z]'+@keyword+'[^a-z]%' 
					 or convert(varchar(max),@comparedate,101) like @keyword+'[^a-z]%'
                     or convert(varchar(max),@comparedate,101) like '%[^a-z]'+@keyword
                     or convert(varchar(max),@comparedate,101) = @keyword) as [Match])
	else
	SET @Result = (select count(*) from (select 1 as matched where convert(varchar(max),@comparedate,101) like '%'+@keyword+'%') as [Match])
	
    RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [CS].[KeywordDollarMatch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [CS].[KeywordDollarMatch] (@keyword VARCHAR(max), @comparedollar decimal, @matchwholeword bit)
RETURNS bit
AS BEGIN
    DECLARE @Result bit
	Declare @keywordclean varchar(max)
	set @keywordclean = replace(@keyword, '$', '')
	Declare @CompareDollarText varchar(max)
	set @CompareDollarText = convert(varchar(max),@comparedollar)
	
	if @matchwholeword = 1
	SET @Result = (select count(*) from (select 1 as matched where @CompareDollarText like '%[^a-z]'+@keywordclean+'[^a-z]%' 
					 or @CompareDollarText like @keywordclean+'[^a-z]%'
                     or @CompareDollarText like '%[^a-z]'+@keywordclean
                     or @CompareDollarText = @keywordclean) as [Match])
	else
	SET @Result = (select count(*) from (select 1 as matched where @CompareDollarText like '%'+@keywordclean+'%') as [Match])
	
    RETURN @Result
END


GO
/****** Object:  UserDefinedFunction [CS].[KeywordPercentMatch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [CS].[KeywordPercentMatch] (@keyword VARCHAR(max), @comparepercent int, @matchwholeword bit)
RETURNS bit
AS BEGIN
    DECLARE @Result bit
	Declare @keywordclean varchar(max)
	set @keywordclean = replace(@keyword, '%', '')
	Declare @ComparePercentText varchar(max)
	set @ComparePercentText = convert(varchar(max),@comparepercent)
	
	if @matchwholeword = 1
	SET @Result = (select count(*) from (select 1 as matched where @ComparePercentText like '%[^a-z]'+@keywordclean+'[^a-z]%' 
					 or @ComparePercentText like @keywordclean+'[^a-z]%'
                     or @ComparePercentText like '%[^a-z]'+@keywordclean
                     or @ComparePercentText = @keywordclean) as [Match])
	else
	SET @Result = (select count(*) from (select 1 as matched where @ComparePercentText like '%'+@keywordclean+'%') as [Match])
	
    RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [CS].[KeywordTextMatch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [CS].[KeywordTextMatch] (@keyword VARCHAR(max), @comparetext varchar(max), @matchwholeword bit)
RETURNS bit
AS BEGIN
    DECLARE @Result bit
	
	if @matchwholeword = 1
	SET @Result = (select count(*) from (select 1 as matched where @comparetext like '%[^a-z]'+@keyword+'[^a-z]%' 
					 or @comparetext like @keyword+'[^a-z]%'
                     or @comparetext like '%[^a-z]'+@keyword
                     or @comparetext = @keyword) as [Match])
	else
	SET @Result = (select count(*) from (select 1 as matched where @comparetext like '%'+@keyword+'%') as [Match])
	
    RETURN @Result
END

GO
/****** Object:  Table [CS].[GppMedCostShareGridValues]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CS].[GppMedCostShareGridValues](
	[MemberGroupID] [bigint] NOT NULL,
	[PlanID] [bigint] NOT NULL,
	[CSPProductID] [int] NOT NULL,
	[RwID] [int] NOT NULL,
	[CopayDollar] [decimal](18, 2) NULL,
	[CoinsPercent] [int] NULL,
	[ApplyCoinsToDed] [int] NULL,
	[Comments] [varchar](max) NULL,
	[DoesDeductibleApply] [int] NULL,
	[AreMedRxDedCombined] [int] NULL,
	[MedInnIndDed] [int] NULL,
	[MedInnFamDed] [int] NULL,
	[MedInnIndOopm] [int] NULL,
	[MedInnFamOopm] [int] NULL,
 CONSTRAINT [PK_GppMedCostShareGridValues] PRIMARY KEY CLUSTERED 
(
	[MemberGroupID] ASC,
	[PlanID] ASC,
	[CSPProductID] ASC,
	[RwID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [CS].[GppMedCostShareProductSettings]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CS].[GppMedCostShareProductSettings](
	[MemberGroupID] [bigint] NOT NULL,
	[PlanID] [bigint] NOT NULL,
	[CSPProductID] [int] NOT NULL,
	[HasLifetimeMax] [int] NULL,
	[LifetimeMaxAmount] [int] NULL,
	[IsProductGated] [int] NULL,
 CONSTRAINT [PK_GppMedCostShareProductSettings] PRIMARY KEY CLUSTERED 
(
	[MemberGroupID] ASC,
	[PlanID] ASC,
	[CSPProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CS].[GppMedCostShareRowMapping]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CS].[GppMedCostShareRowMapping](
	[RwID] [int] IDENTITY(1,1) NOT NULL,
	[RowLabel] [varchar](500) NOT NULL,
	[OrderNum] [int] NOT NULL,
 CONSTRAINT [PK_GppMedCostShareRowMapping] PRIMARY KEY CLUSTERED 
(
	[RwID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [CS].[GppMedCostShareValues]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CS].[GppMedCostShareValues](
	[MemberGroupID] [bigint] NOT NULL,
	[PlanID] [bigint] NOT NULL,
	[Comments] [varchar](max) NULL,
	[Exclusions] [varchar](max) NULL,
 CONSTRAINT [PK_GppMedCostShareValues] PRIMARY KEY CLUSTERED 
(
	[MemberGroupID] ASC,
	[PlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO

--MedBenMValues
alter table btb.cs.MedBenMValues add AddBenInfoBCCSServiceIDs varchar(max) null;
alter table btb.cs.MedBenMValues add AddBenInfoBCCSServiceRule varchar(max) null;
alter table btb.cs.MedBenMValues add BenSummInfoMemberGeneralInfo varchar(max) null;
alter table btb.cs.MedBenMValues add BenSummInfoProviderInfo varchar(max) null;
alter table btb.cs.MedBenMValues add MyUHCSummInfoMemberGeneralInfo varchar(max) null;

GO
--LimitsAndCodes
alter table btb.cs.LimitsAndCodes add ServiceID varchar(max) null;
alter table btb.cs.LimitsAndCodes add ServiceRule varchar(max) null;

GO

/****** Object:  StoredProcedure [CS].[Get_GPP_For_IEX_ProductReportExport]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Vandana
-- Create date: 14/07/2021
-- Description: For IEX ProductInfoExport Report - GPP tab  
-- =============================================
CREATE proc [CS].[Get_GPP_For_IEX_ProductReportExport]      
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
GO
/****** Object:  StoredProcedure [CS].[Get_HS_Core_For_IEX_ProductReportExport]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[CS].[Get_HS_Core_For_IEX_ProductReportExport] 40278, 40601
CREATE proc [CS].[Get_HS_Core_For_IEX_ProductReportExport]
(@MemberGroupID int,
@PlanID int)
AS
/*
GroupID: 4444
	[CS].Get_RPT_Product 2,35,'5,6,7'
	[CS].[Get_HS_Core_For_ProductReportExport] 2, 2

  select a.ScreenID, a.FieldID, a.FieldName, b.ScreenTitle,c.*
  from cs.dynamicfielddefs a, cs.Screens b, cs.MedBenMValues c
  where a.ControlType = 1548 and a.ScreenID = b.ScreenID and c.FieldID = a.FieldID
  and a.ScreenID = 254

*/
BEGIN

declare @Dynamictbl table  
(rowNo int Identity(1,1),
ScreenID int,
ScreenOrder int,
HealthService varchar(max),  

Label1 varchar(max) null,
ServiceInfoBenEffDate varchar(max),  
ServiceInfoBenefitCompletionStatusID varchar(max),  
ServiceInfoCoveredID varchar(max),  
ServiceInfoCoveredValidValueID int,
ServiceInfoCoveredByID varchar(max),  

Label2 varchar(max),

AuthInfoGoldStarApplicableID varchar(max),
AuthInfoGoldStarComments varchar(max),
AuthInfoGeneralComments varchar(max),  
Label3 varchar(max),  
AddBenInfoRules varchar(max),  
AddBenInfoProviderRestrictions varchar(max),  
AddBenInfoBenefitRestrictions varchar(max),  
AddBenInfoAgeRestrictions varchar(max),  
AddBenInfoGenderRestrictions varchar(max),  
AddBenInfoProcessingRequirements varchar(max),  
AddBenInfoPOSBillTypeImpl varchar(max),  
AddBenInfoBenefitLimitComments varchar(max),  
AddBenInfoGeneralLimitComments varchar(max),
AddBenInfoCCAMComments varchar(max),
AddBenInfoBCOComments varchar(max),
AddBenInfoBCCSServiceIDs varchar(max),
AddBenInfoBCCSServiceRule varchar(max),
Label4 varchar(max),
BenSummInfoMemberGeneralInfo varchar(max),
BenSummInfoProviderInfo varchar(max),
Label5 varchar(max),
MyUHCSummInfoMemberGeneralInfo varchar(max)
)  

insert into @Dynamictbl(ScreenID,ScreenOrder,HealthService,Label1,ServiceInfoBenEffDate,ServiceInfoBenefitCompletionStatusID,  
ServiceInfoCoveredID,ServiceInfoCoveredValidValueID,ServiceInfoCoveredByID,Label2,AuthInfoGoldStarApplicableID,
AuthInfoGoldStarComments,AuthInfoGeneralComments,Label3,AddBenInfoRules,AddBenInfoProviderRestrictions,AddBenInfoBenefitRestrictions,AddBenInfoAgeRestrictions,AddBenInfoGenderRestrictions,AddBenInfoProcessingRequirements,AddBenInfoPOSBillTypeImpl,AddBenInfoBenefitLimitComments,AddBenInfoGeneralLimitComments ,
AddBenInfoCCAMComments,AddBenInfoBCOComments ,AddBenInfoBCCSServiceIDs ,AddBenInfoBCCSServiceRule ,Label4 ,
BenSummInfoMemberGeneralInfo ,BenSummInfoProviderInfo ,Label5 ,MyUHCSummInfoMemberGeneralInfo)  
	SELECT def.ScreenID as ScreenID, (select ScreenOrder from CS.Screens s1 where s1.ScreenID =def.ScreenID) as ScreenOrder,(select Screentitle from CS.Screens s where s.ScreenID =def.ScreenID) as HealthService,

	'Service Information' as Label1,
	convert(varchar,convert(date,ServiceInfoBenEffDate,101),101) as ServiceInfoBenEffDate,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoBenefitCompletionStatusID) as ServiceInfoBenefitCompletionStatusID,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoCoveredID) as ServiceInfoCoveredID, ServiceInfoCoveredID as ServiceInfoCoveredValidValueID,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoCoveredByID) as ServiceInfoCoveredByID,

	'Authorization Information' as Label2,
	
	(select ValidValueText from cs.validvalues where ValidValueID=AuthInfoGoldStarApplicableID) as AuthInfoGoldStarApplicableID,
	AuthInfoGoldStarComments,
	AuthInfoGeneralComments,

	'Additional Benefit Information' as Label3,
	AddBenInfoRules,
	AddBenInfoProviderRestrictions,
	AddBenInfoBenefitRestrictions,
	AddBenInfoAgeRestrictions,
	AddBenInfoGenderRestrictions,
	AddBenInfoProcessingRequirements,
	AddBenInfoPOSBillTypeImpl,
	AddBenInfoBenefitLimitComments,
	AddBenInfoGeneralLimitComments,
	AddBenInfoCCAMComments,
	AddBenInfoBCOComments,
	AddBenInfoBCCSServiceIDs,
	AddBenInfoBCCSServiceRule,
	'Benefit Summary Information' as Label4,
	BenSummInfoMemberGeneralInfo,
	BenSummInfoProviderInfo,
	'MyUHC Summary Information' as Label5,
	MyUHCSummInfoMemberGeneralInfo
	FROM [CS].[MedBenMValues] mbv with(nolock)
	join [CS].[DynamicFieldDefs] def with(nolock) on mbv.FieldID=def.FieldID
	where mbv.MemberGroupID=@MemberGroupID and mbv.PlanID=@PlanID  
	AND def.ScreenID in (Select ScreenID From CS.Screens with(nolock) WHERE Convert(varchar, ProductTypeId) = (Select FieldValue FROM CS.DynamicFieldValues with(nolock) WHERE MemberGroupID=@MemberGroupID AND FieldID=1245))
	--AND mbv.ScreenID=254

	Update @Dynamictbl
	Set ServiceInfoCoveredByID='[NOT APPLICABLE]',AuthInfoGoldStarApplicableID='[NOT APPLICABLE]',
	AuthInfoGoldStarComments='[NOT APPLICABLE]', AuthInfoGeneralComments='[NOT APPLICABLE]', AddBenInfoRules='[NOT APPLICABLE]',
	AddBenInfoProviderRestrictions='[NOT APPLICABLE]', AddBenInfoBenefitRestrictions='[NOT APPLICABLE]', AddBenInfoAgeRestrictions='[NOT APPLICABLE]',
	AddBenInfoGenderRestrictions='[NOT APPLICABLE]', AddBenInfoProcessingRequirements='[NOT APPLICABLE]', AddBenInfoPOSBillTypeImpl='[NOT APPLICABLE]',
	BenSummInfoMemberGeneralInfo = '[NOT APPLICABLE]',
	BenSummInfoProviderInfo = '[NOT APPLICABLE]', MyUHCSummInfoMemberGeneralInfo='[NOT APPLICABLE]'
	Where ServiceInfoCoveredValidValueID in (1550,1553,1554,1555)

	Select * from @Dynamictbl
	Order By ScreenOrder
END

GO
/****** Object:  StoredProcedure [CS].[Get_MED_CostShareGrid_For_ProductReportExport]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Vandana
-- Create date: 21/07/2021
-- Description: For ProductInfoExport Report - Med CS Details IEX product 
-- =============================================
CREATE proc [CS].[Get_MED_CostShareGrid_For_ProductReportExport]      
(@MemberGroupID int,      
@PlanId int) 
   
as       
BEGIN  
    
Select 

CSP.CSPProductDesc as CSPProductDescription,
RM.RowLabel as BenefitName,
CASE WHEN CopayDollar IS NOT NULL THEN CONCAT('$', CopayDollar) ELSE NULL END AS CopayDollar,
CASE WHEN CoinsPercent IS NOT NULL THEN CONCAT(CoinsPercent,'%') ELSE NULL END AS CoinsPercent,
VV.ValidValueText as DoesDeductibleApply,
VV1.ValidValueText as AreMedRxDedCombined,
CASE WHEN MedInnIndDed IS NOT NULL THEN CONCAT('$', MedInnIndDed) ELSE NULL END AS MedInnIndDed,
CASE WHEN MedInnFamDed IS NOT NULL THEN CONCAT('$', MedInnFamDed) ELSE NULL END AS MedInnFamDed,
CASE WHEN MedInnIndOopm IS NOT NULL THEN CONCAT('$', MedInnIndOopm) ELSE NULL END AS MedInnIndOopm,
CASE WHEN MedInnFamOopm IS NOT NULL THEN CONCAT('$', MedInnFamOopm) ELSE NULL END AS MedInnFamOopm,
Comments

from [CS].[GppMedCostShareGridValues] GV
Inner Join [CS].[GppMedCostShareRowMapping] RM on GV.RwID = RM.RwID
Inner Join [CS].[MemberGroupCSPProducts] CSP on GV.CSPProductID = CSP.CSPProductID
Left Outer Join [CS].ValidValues VV on GV.DoesDeductibleApply = VV.ValidValueID
Left Outer Join [CS].ValidValues VV1 on GV.AreMedRxDedCombined = VV1.ValidValueID
Where GV.MemberGroupID = @MemberGroupID and PlanID = @PlanId
Order By CSP.CSPProductDesc, RM.OrderNum

END
GO
/****** Object:  StoredProcedure [CS].[SP_CreateProductFromCopy]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [CS].[SP_CreateProductFromCopy]
@pPlanIDToCopy bigint,
@pMemberGroupIDToCopy bigint,
@pPlanEffDate varchar(10),
@pProductDescription varchar(4000),
@pNewMemberGroupID varchar(4000),
@pCreatedBy int,
@pCreateMethod int = 982,
@pIsRenewable bit = 0
 AS    

 
DECLARE @createDateTime datetime
Set @createDateTime = getdate()

--Get source values of original plan
select * 
into #sourceDynamicVals
from btb.cs.DynamicFieldValues 
where MemberGroupID = @pMemberGroupIDToCopy and PlanID = @pPlanIDToCopy
 and FieldID in (14,15,16)

DECLARE @sourceProductDescription varchar(4000)
set @sourceProductDescription = (select top 1 FieldValue from #sourceDynamicVals where FieldID = 15)

DECLARE @sourceProductID varchar(4000)
set @sourceProductID = (select top 1 FieldValue from #sourceDynamicVals where FieldID = 16)

DECLARE @sourceProductEffDate varchar(4000)
set @sourceProductEffDate = (select top 1 FieldValue from #sourceDynamicVals where FieldID = 14)

--Get default values for member group
select * 
into #defaultDynamicVals
from btb.cs.DynamicFieldValues 
where MemberGroupID = @pMemberGroupIDToCopy and PlanID = -1
 and FieldID in (4,3,73)

DECLARE @newGroupID varchar(4000)
set @newGroupID = (select top 1 FieldValue from #defaultDynamicVals where FieldID = 4)

DECLARE @newGroupDescription varchar(4000)
set @newGroupDescription = (select top 1 FieldValue from #defaultDynamicVals where FieldID = 3)

DECLARE @newHealthPlanID varchar(4000)
set @newHealthPlanID = (select top 1 FieldValue from #defaultDynamicVals where FieldID = 73)

Declare @newPlanID bigint 

Begin Tran

--Plan
INSERT INTO btb.cs.[Plans] 
                                   ([MemberGroupID] ,[CreateDate] ,[CreatedBy]  ,[CreateMethod]) 
                             VALUES 
                                   (@pNewMemberGroupID
                                   ,@createDateTime
                                   ,@pCreatedBy
                                   ,@pCreateMethod)
								   
set @newPlanID = @@IDENTITY

--Dynamic fields
INSERT INTO  btb.cs.[DynamicFieldValues] 
                               ([MemberGroupID] 
                               ,[PlanID] 
                               ,[FieldID] 
                               ,[FieldValue]) 
                         select @newPlanID
                               ,@pNewMemberGroupID
                               ,FieldID 
                               ,FieldValue 
                          from  btb.cs.[DynamicFieldValues]  WITH (NOLOCK) 
                          where MemberGroupID = @pMemberGroupIDToCopy
                            and PlanID = @pPlanIDToCopy

--Update prod desc
update  btb.cs.DynamicFieldValues 
    set FieldValue = @pProductDescription
    where FieldID = 15
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

--Update health plan id
update  btb.cs.DynamicFieldValues 
    set FieldValue = @newHealthPlanID
    where FieldID = 10
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

--Update Group Id
update  btb.cs.DynamicFieldValues 
    set FieldValue = @newGroupID
    where FieldID = 12
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

--Update Group Description
update  btb.cs.DynamicFieldValues 
    set FieldValue = @newGroupDescription
    where FieldID = 11
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

--Update Plan Eff date
update  btb.cs.DynamicFieldValues 
    set FieldValue = @pPlanEffDate
    where FieldID = 14
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

--Update Create Method
update  btb.cs.DynamicFieldValues 
    set FieldValue = @pCreateMethod
    where FieldID = 28
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

if @pIsRenewable = 1 
begin
--Update Create Method
update  btb.cs.DynamicFieldValues 
    set FieldValue = 985
    where FieldID = 33
        AND MemberGroupID =@pNewMemberGroupID
        AND PlanID = @newPlanID

end


-- update the plan create source to the id of the plan being copied
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 29 and MemberGroupID = @pNewMemberGroupID and PlanID = @newPlanID;
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pNewMemberGroupID,@newPlanID,29,@pPlanIDToCopy )

--  update the source prod desc
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 30 and MemberGroupID = @pNewMemberGroupID and PlanID = @newPlanID
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pNewMemberGroupID,@newPlanID,30, @sourceProductDescription)


--  update the source prod id
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 31 and MemberGroupID = @pNewMemberGroupID and PlanID = @newPlanID
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pNewMemberGroupID,@newPlanID,31, @sourceProductID)
                    

--  update the source eff date
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 32 and MemberGroupID = @pNewMemberGroupID and PlanID = @newPlanID
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pNewMemberGroupID,@newPlanID,32, @sourceProductEffDate)
                    

--  update the internal group id
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 26 and MemberGroupID = @pNewMemberGroupID and PlanID = @newPlanID
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pNewMemberGroupID,@newPlanID,26, @pMemberGroupIDToCopy)
                    
--  update the internal product id
--delete it first in case it exists
delete from btb.cs.DynamicFieldValues where fieldid = 27 and MemberGroupID = @pMemberGroupIDToCopy and PlanID = @newPlanID
--reinsert it
INSERT INTO btb.cs.[DynamicFieldValues] 
                   ([MemberGroupID] 
                   ,[PlanID] 
                   ,[FieldID] 
                   ,[FieldValue]) 
                VALUES (@pMemberGroupIDToCopy,@newPlanID,27, @newPlanID)

-- copy the gpp coins 
INSERT INTO btb.cs.[GPPCoinsValues]
        ([MemberGroupID]
        ,[PlanID]
        ,[HasCoins]
        ,[CoinsDifferentForOON]
        ,[CoinsComments])
    SELECT @pNewMemberGroupID
        ,@newPlanID
        ,HasCoins
        ,CoinsDifferentForOON
        ,CoinsComments
    FROM btb.cs.[GPPCoinsValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


INSERT INTO btb.cs.[GPPCoinsGridValues]
            ([MemberGroupID]
            ,[PlanID]
            ,[RwID]
            ,[CoinsPercent]
            ,[ApplyCoinsToDed]
            ,[ApplyCoinsToOOP]
            ,[Comments])
        SELECT @pNewMemberGroupID
            ,@newPlanID
            ,RwID
            ,CoinsPercent
            ,ApplyCoinsToDed
            ,ApplyCoinsToOOP
            ,Comments
        FROM btb.cs.[GPPCoinsGridValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;

                    

-- copy the gpp copay 
INSERT INTO btb.cs.[GPPCopayValues]
        ([MemberGroupID]
        ,[PlanID]
        ,[HasCopayments]
        ,[CopayDifferentForOON]
        ,[CopayComments]
        ,[CopayExclusions])
    SELECT @pNewMemberGroupID
        ,@newPlanID
        ,HasCopayments
        ,CopayDifferentForOON
        ,CopayComments
        ,CopayExclusions
    FROM btb.cs.[GPPCopayValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


INSERT INTO btb.cs.[GPPCopayGridValues]
        ([MemberGroupID]
        ,[PlanID]
        ,[RwID]
        ,[CopayDollar]
        ,[CopayMinDollar]
        ,[CopayMaxDollar]
        ,[Comments])
    SELECT @pNewMemberGroupID
        ,@newPlanID
        ,RwID
        ,CopayDollar
        ,CopayMinDollar
        ,CopayMaxDollar
        ,Comments
    FROM btb.cs.[GPPCopayGridValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;
                    


-- copy the ded 
INSERT INTO btb.cs.[GPPDedOOPMValues]
            ([MemberGroupID]
            ,[PlanID]
            ,[DoesThisProdHaveDed]
            ,[AreMedRxDedCombined]
            ,[DoesThisProdHaveOOPMax]
            ,[AreINNOONMaxCombined]
            ,[DoesThisProdHaveLifeMax]
            ,[AreAmountsDiffForOON]
            ,[DedComments])
        SELECT
            @pNewMemberGroupID
            ,@newPlanID
            ,[DoesThisProdHaveDed]
            ,[AreMedRxDedCombined]
            ,[DoesThisProdHaveOOPMax]
            ,[AreINNOONMaxCombined]
            ,[DoesThisProdHaveLifeMax]
            ,[AreAmountsDiffForOON]
            ,[DedComments]
        FROM btb.cs.[GPPDedOOPMValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


INSERT INTO btb.cs.[GPPDedOOPGridValues]
            ([MemberGroupID]
            ,[PlanID]
            ,[RwID]
            ,[Amount]
            ,[Comments])
        SELECT @pNewMemberGroupID
            ,@newPlanID
            ,RwID
            ,Amount
            ,Comments
        FROM btb.cs.[GPPDedOOPGridValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;
                    


-- copy the Med Ben Related Values
    INSERT INTO btb.cs.[MedBenMValues]
                    ([MemberGroupID]
                    ,[PlanID]
                    ,[FieldID]
                    ,[ServiceInfoBenEffDate]
                    ,[ServiceInfoBenefitCompletionStatusID]
                    ,[ServiceInfoCoveredID]
                    ,[ServiceInfoCoveredByID]
                    ,[VendorInfoCoverageDetailsID]
                    ,[VendorInfoVendorName]
                    ,[VendorInfoInternalVendorContact]
                    ,[VendorInfoExternalVendor]
                    ,[VendorInfoVendorEffDate]
                    ,[VendorInfoVendorTermDate]
                    ,[VendorInfoVendorComments]
                    ,[AuthInfoIsThereAWaverPeriodID]
                    ,[AuthInfoAuthWaiverStartDate]
                    ,[AuthInfoAuthWaiverEndDate]
                    ,[AuthInfoWaverAppliedToID]
                    ,[AuthInfoWaiverComments]
                    ,[AuthInfoGoldStarApplicableID]
                    ,[AuthInfoGoldStarComments]
                    ,[AuthInfoGeneralComments]
                    ,[GPInfoMemberLiabilityID]
                    ,[GPInfoTotalOOP]
                    ,[GPInfoLifeTimeMax]
                    ,[GPInfoCopayExceptions]
                    ,[GPInfoPaymentComments]
                    ,[SettingINNCostShareLoadMethodID]
                    ,[SettingOONRequireDiffInfoID]
                    ,[AddBenInfoRules]
                    ,[AddBenInfoProviderRestrictions]
                    ,[AddBenInfoBenefitRestrictions]
                    ,[AddBenInfoAgeRestrictions]
                    ,[AddBenInfoGenderRestrictions]
                    ,[AddBenInfoProcessingRequirements]
                    ,[AddBenInfoPOSBillTypeImpl]
                    ,[AddBenInfoBenefitLimitComments]
                    ,[AddBenInfoGeneralLimitComments]
                    ,[AddBenInfoCCAMComments]
                    ,[AddBenInfoBCOComments])
        SELECT @pNewMemberGroupID
            ,@newPlanID
                    ,[FieldID]
                    ,[ServiceInfoBenEffDate]
                    ,[ServiceInfoBenefitCompletionStatusID]
                    ,[ServiceInfoCoveredID]
                    ,[ServiceInfoCoveredByID]
                    ,[VendorInfoCoverageDetailsID]
                    ,[VendorInfoVendorName]
                    ,[VendorInfoInternalVendorContact]
                    ,[VendorInfoExternalVendor]
                    ,[VendorInfoVendorEffDate]
                    ,[VendorInfoVendorTermDate]
                    ,[VendorInfoVendorComments]
                    ,[AuthInfoIsThereAWaverPeriodID]
                    ,[AuthInfoAuthWaiverStartDate]
                    ,[AuthInfoAuthWaiverEndDate]
                    ,[AuthInfoWaverAppliedToID]
                    ,[AuthInfoWaiverComments]
                    ,[AuthInfoGoldStarApplicableID]
                    ,[AuthInfoGoldStarComments]
                    ,[AuthInfoGeneralComments]
                    ,[GPInfoMemberLiabilityID]
                    ,[GPInfoTotalOOP]
                    ,[GPInfoLifeTimeMax]
                    ,[GPInfoCopayExceptions]
                    ,[GPInfoPaymentComments]
                    ,[SettingINNCostShareLoadMethodID]
                    ,[SettingOONRequireDiffInfoID]
                    ,[AddBenInfoRules]
                    ,[AddBenInfoProviderRestrictions]
                    ,[AddBenInfoBenefitRestrictions]
                    ,[AddBenInfoAgeRestrictions]
                    ,[AddBenInfoGenderRestrictions]
                    ,[AddBenInfoProcessingRequirements]
                    ,[AddBenInfoPOSBillTypeImpl]
                    ,[AddBenInfoBenefitLimitComments]
                    ,[AddBenInfoGeneralLimitComments]
                    ,[AddBenInfoCCAMComments]
                    ,[AddBenInfoBCOComments]
        FROM btb.cs.[MedBenMValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


    INSERT INTO btb.cs.[MedBenSettingsGridMainValues]
                    ([MemberGroupID]
                    ,[PlanID]
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[Home]
                    ,[ProfSvcs]
                    ,[Other]
                    ,[OutpFac]
                    ,[InptFac])
        SELECT @pNewMemberGroupID
            ,@newPlanID
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[Home]
                    ,[ProfSvcs]
                    ,[Other]
                    ,[OutpFac]
                    ,[InptFac]
        FROM btb.cs.[MedBenSettingsGridMainValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


    INSERT INTO btb.cs.[MedBenSettingsGridOtherValues]
                    ([MemberGroupID]
                    ,[PlanID]
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[Home]
                    ,[ProfSvcs]
                    ,[Other]
                    ,[OutpFac]
                    ,[InptFac])
        SELECT @pNewMemberGroupID
            ,@newPlanID
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[Home]
                    ,[ProfSvcs]
                    ,[Other]
                    ,[OutpFac]
                    ,[InptFac]
        FROM btb.cs.[MedBenSettingsGridOtherValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;


    INSERT INTO btb.cs.[MedBenVendorHistoryGridValues]
                    ([MemberGroupID]
                    ,[PlanID]
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[VendorName]
                    ,[EffDate]
                    ,[TermDate])
        SELECT @pNewMemberGroupID
            ,@newPlanID
                    ,[ScreenID]
                    ,[FieldID]
                    ,[RwID]
                    ,[VendorName]
                    ,[EffDate]
                    ,[TermDate]
        FROM btb.cs.[MedBenVendorHistoryGridValues]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;

                    

-- copy the Benefit Links
INSERT INTO btb.cs.[GeneralLinks]
            ([MemberGroupID]
            ,[PlanID]
            ,[LinkID]
            ,[EffDt]
            ,[TermDt]
            ,[LinkStatusID]
            ,[ScreenID]
            ,[LinkName]
            ,[URL]
            ,[Comments]
            ,[LastUpdatedBy]
            ,[LastUpdatedDate]) 
            SELECT @pNewMemberGroupID
            ,@newPlanID
            ,[LinkID]
            ,[EffDt]
            ,[TermDt]
            ,[LinkStatusID]
            ,[ScreenID]
            ,[LinkName]
            ,[URL]
            ,[Comments]
            ,[LastUpdatedBy]
            ,[LastUpdatedDate] FROM btb.cs.[GeneralLinks]  WITH (NOLOCK)
    WHERE MemberGroupID = @pMemberGroupIDToCopy 
    AND PlanID = @pPlanIDToCopy ;                    


Commit Tran


select * from btb.cs.Plans where planid = @newPlanID



GO
/****** Object:  StoredProcedure [CS].[SP_GetDynamicFieldDefAndValueListForPlanAndScreen]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [CS].[SP_GetDynamicFieldDefAndValueListForPlanAndScreen]
@p0MemberGroupID bigint,
@p1PlanID bigint,
@p2ScreenID int
 AS    
 select z.*,b.ValidValueText as ControlTypeText   
from 
(SELECT a.*  
    ,Convert(BIT,0) as HiddenByProduct  
    FROM  
    (select v.PlanID, a.FieldID  
        ,a.ScreenID  
        ,a.FieldName  
        ,a.ControlType  
        ,a.ScreenOrder  
        ,a.CreateDate  
        ,a.CreatedBy  
        ,a.LastupDateDate  
        ,a.LastUpdateBy  
        ,a.ClonedFieldID  
        ,v.FieldValue as [Value]  
        ,Convert(bit,0) as IsEnabled  
        ,Convert(bit,1) as IsVisible        
    from  BTb.CS.DynamicFieldDefs a WITH (NOLOCK) 
        left outer join   BTb.CS.DynamicFieldValues v WITH (NOLOCK) on v.FieldID = a.FieldID and v.MemberGroupID = @p0MemberGroupID and v.PlanId = @p1PlanID and a.ScreenID = @p2ScreenID 
    where a.ScreenID = @p2ScreenID) a  
    ) z 
    left outer join  BTb.CS.ValidValues b WITH (NOLOCK) on z.ControlType = 801 and Convert(varchar(10),b.ValidValueId) = z.Value ;



GO
/****** Object:  StoredProcedure [CS].[SP_GetDynamicFieldValueListForMbrGroupPlanAndScreen]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [CS].[SP_GetDynamicFieldValueListForMbrGroupPlanAndScreen]
@p0MemberGroupID bigint,
@p1PlanID bigint,
@p2ScreenID int,
@p3AddlFields varchar(max)
 AS   
 
 declare @DynamicFieldResults table(
	 MemberGroupID bigint,
	 PlanID bigint,
	 FieldID int,
	 FieldValue varchar(max),
	 ControlType int,
	 HiddenByProduct bit
	 );

insert into @DynamicFieldResults
	select      a.* ,
        CONVERT(BIT,0) HiddenByProduct
FROM
        (
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID        AS PlanID       ,
                        a.FieldID                        ,
                        b.FieldValue                     ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues b
                ON
                        a.FieldID       = b.FieldID
                AND     a.ClonedFieldID = -1
                AND     b.PlanID        = @p1PlanID
                AND     b.MemberGroupID = @p0MemberGroupID
                WHERE
                        a.screenID      = @p2ScreenID
                AND     a.clonedfieldid = -1)

UNION
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID        AS PlanID       ,
                        a.FieldID                        ,
                        v.FieldValue                     ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a,
                        [Btb].[CS].ScreenGroups     b,
                        [Btb].[CS].DynamicFieldDefs ac
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues v
                ON
                        v.fieldid       = ac.fieldid
                AND     v.membergroupid = @p0MemberGroupID
                AND     v.planid        = -1
                WHERE
                        a.clonedfieldid > -1
                AND     ac.fieldid      = a.clonedfieldid
                AND     ac.screenid     = b.screenid
                AND     b.ScreenGroup   = 'Policy'
                AND     a.ScreenID      = @p2ScreenID
                AND     a.clonedfieldid > -1)

UNION
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID        AS PlanID       ,
                        a.FieldID                        ,
                        v.FieldValue                     ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a,
                        [Btb].[CS].ScreenGroups     b,
                        [Btb].[CS].DynamicFieldDefs ac
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues v
                ON
                        v.fieldid       = ac.fieldid
                AND     v.membergroupid = @p0MemberGroupID
                AND     v.planid        = @p1PlanID
                WHERE
                        a.clonedfieldid > -1
                AND     ac.fieldid      = a.clonedfieldid
                AND     ac.screenid     = b.screenid
                AND     b.ScreenGroup  != 'Policy'
                AND     a.ScreenID      = @p2ScreenID
                AND     a.clonedfieldid > -1)) a

select Item as fieldID 
into #fields
from cs.splitstring(@p3AddlFields, ',')

 IF EXISTS (SELECT * FROM #fields)
begin

insert into @DynamicFieldResults
SELECT
        a.* ,
        CONVERT(BIT,0) AS HiddenByProduct
FROM
        (
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID AS PlanID       ,
                        a.FieldID           ,
                        b.FieldValue        ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a
                JOIN
                        #fields f
                ON
                        f.fieldID = a.fieldID
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues b
                ON
                        a.FieldID       = b.FieldID
                AND     a.ClonedFieldID = -1
                AND     b.PlanID        = @p1PlanID
                AND     b.MemberGroupID = @p0MemberGroupID
                WHERE
                        a.clonedfieldid = -1)

UNION
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID AS PlanID       ,
                        a.FieldID           ,
                        v.FieldValue        ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a
                JOIN
                        [Btb].[CS].DynamicFieldDefs ac
                ON
                        ac.fieldid = a.clonedfieldid
                JOIN
                        [Btb].[CS].ScreenGroups b on ac.screenid = b.screenid
                JOIN
                        #fields f
                ON
                        f.fieldID = a.fieldID
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues v
                ON
                        v.fieldid       = ac.fieldid
                AND     v.membergroupid = @p0MemberGroupID
                AND     v.planid        = -1
                WHERE
                        a.clonedfieldid > -1
                AND     b.ScreenGroup   = 'Policy'
                AND     a.clonedfieldid > -1)

UNION
        (
                SELECT
                        @p0MemberGroupID AS MemberGroupID,
                        @p1PlanID AS PlanID       ,
                        a.FieldID           ,
                        v.FieldValue        ,
                        a.ControlType
                FROM
                        [Btb].[CS].DynamicFieldDefs a
                JOIN
                        [Btb].[CS].DynamicFieldDefs ac
                ON
                        ac.fieldid = a.clonedfieldid
                JOIN
                        [Btb].[CS].ScreenGroups b
                ON
                        ac.screenid = b.screenid
                JOIN
                        #fields f
                ON
                        f.fieldID = a.fieldID
                LEFT OUTER JOIN
                        [Btb].[CS].DynamicFieldValues v
                ON
                        v.fieldid       = ac.fieldid
                AND     v.membergroupid = @p0MemberGroupID
                AND     v.planid        = @p1PlanID
                WHERE
                        a.clonedfieldid > -1
                AND     b.ScreenGroup  != 'Policy'
                AND     a.clonedfieldid > -1)) a
end
-- 1222, 1223, 1224, 1225, 1226, 1227, 1237

update @DynamicFieldResults 
	set FieldValue = (select customerid from btb.cs.MemberGroups where membergroupid = @p0MemberGroupID)
	where ControlType = 1222

select * from @DynamicFieldResults


GO
/****** Object:  StoredProcedure [CS].[Sp_GroupSearch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [CS].[Sp_GroupSearch]
	-- Add the parameters for the stored procedure here

	 @pGroupId nvarchar (4000) ='%',
	 @pGroupDesc nvarchar (4000)  = '%',
	 @pBtbGroupId bigint = 0  ,
	 @pHealthPlanName nvarchar(4000)  ='%' ,
	 @pGroupStatus nvarchar(10) = null,
	 @pDeleted nvarchar(1)  ='N'

	AS
BEGIN

	
select piv.MemberGroupID, 
	   piv.GroupID, 
	   piv.GroupDescription, 
	   vv.ValidValueText as GroupStatus, 
	   piv.HealthPlanName, 
	   piv.CustomerID, 
	   piv.Deleted, 
	   CASE WHEN piv.Deleted='Y' Then 'Yes' ELSE 'No' END as DeletedText,
	   piv.ProductTypeID,
	   piv.CspGoLiveDate,
	   piv.TerminationDate
from (select dfv.MemberGroupID, dfv.FieldValue, mg.CustomerID,mg.Deleted, c.Name as HealthPlanName,
case 
 when dfv.FieldID = 4 Then 'GroupID' 
 when dfv.FieldID = 3 Then 'GroupDescription' 
 when dfv.FieldID = 5 Then 'GroupStatus' 
 when dfv.FieldID = 1245 Then 'ProductTypeID' 
 when dfv.FieldID = 1443 Then 'CspGoLiveDate'
 when dfv.FieldID = 1444 Then 'TerminationDate'
END as FieldName 
 from btb.cs.DynamicFieldValues dfv 
join btb.cs.MemberGroups mg on mg.MemberGroupID = dfv.MemberGroupID
join btb.cs.Customers c on c.CustomerID = mg.CustomerID
where dfv.FieldID in (4,3,5,1245, 1444, 1443) and dfv.PlanID = -1
) flds

pivot 
( 
max(FieldValue) 
for FieldName in ( 
	   GroupID, 
	   GroupDescription, 
	   GroupStatus,
	   ProductTypeID, CspGoLiveDate, TerminationDate) 
) piv 

join btb.cs.ValidValues vv on Convert(varchar,vv.ValidValueID) = piv.GroupStatus
where (piv.GroupID is null or piv.GroupID like @pGroupId )
and piv.GroupDescription like @pGroupDesc
and (@pBtbGroupId <= 0 or piv.MemberGroupID = @pBtbGroupId)
and piv.HealthPlanName like @pHealthPlanName
and (@pGroupStatus is null or piv.GroupStatus = @pGroupStatus)
and (@pDeleted is null or @pDeleted != 'N' or piv.Deleted = 'N')


End


GO
/****** Object:  StoredProcedure [CS].[SP_KeywordSearch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [CS].[SP_KeywordSearch]
@p1Keyword varchar(max),
@p2MatchWholeWord bit,
@p3MemberGroupID bigint,
@p4PlanID bigint
 AS    

 declare @KeywordResults table(
	 FieldID int,
	 MatchingText varchar(max),
	 FieldName varchar(1000),
	 LabelText varchar(max),
	 ScreenID int,
	 ScreenHierarchy varchar(1600),
	 ControlTypeText varchar(1000),
	 ControlTypeID int,
	 ScreenControlToFind varchar(max)
	 );

	 
insert into @KeywordResults  select a.FieldID 
,a.FieldValue as MatchingText 
,b.FieldName		 
,(select z.PropertyValue from BTB.CS.DynamicFieldProperties z where z.FieldID = a.fieldid and z.PropertyType = 792) as LabelText 
,b.ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (b.ScreenID) as ScreenHierarchy 
,(select z.ValidValueText from BTB.CS.ValidValues z where z.ValidValueID = b.ControlType) as ControlTypeText 
,b.ControlType as ControlTypeID 
,('GR_' + convert(varchar(max),a.FieldID)) as  ScreenControlToFind 
from BTB.CS.DynamicFieldValues a, 
BTB.CS.DynamicFieldDefs b 
where a.fieldid = b.fieldid 
and b.ControlType in (800,805,809)  
and cs.KeywordTextMatch(@p1Keyword, a.FieldValue, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
select a.FieldID 
,convert(varchar(max),Convert(date,a.FieldValue),101) as MatchingText 
,b.FieldName		 
,(select z.PropertyValue from BTB.CS.DynamicFieldProperties z where z.FieldID = a.fieldid and z.PropertyType = 792) as LabelText 
,b.ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (b.ScreenID) as ScreenHierarchy 
,(select z.ValidValueText from BTB.CS.ValidValues z where z.ValidValueID = b.ControlType) as ControlTypeText 
,b.ControlType as ControlTypeID 
,('GR_' + convert(varchar(max),a.FieldID)) as  ScreenControlToFind 
from BTB.CS.DynamicFieldValues a, 
BTB.CS.DynamicFieldDefs b 
where a.fieldid = b.fieldid 
and b.ControlType = 812  
and [cs].[KeywordDateMatch](@p1Keyword, a.FieldValue, @p2MatchWholeWord) = 1

and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
select a.FieldID 
,c.ValidValueText as MatchingText 
,b.FieldName		 
,(select z.PropertyValue from BTB.CS.DynamicFieldProperties z where z.FieldID = a.fieldid and z.PropertyType = 792) as LabelText 
,b.ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (b.ScreenID) as ScreenHierarchy 
,(select z.ValidValueText from BTB.CS.ValidValues z where z.ValidValueID = b.ControlType) as ControlType 
,b.ControlType as ControlTypeID 
,('GR_' + convert(varchar(max),a.FieldID)) as  ScreenControlToFind 
from BTB.CS.DynamicFieldValues a, 
BTB.CS.DynamicFieldDefs b, 
BTB.CS.ValidValues c 
where a.fieldid = b.fieldid 
and b.ControlType = 801 
and convert(varchar(max),c.validvalueid) = a.FieldValue 
and [cs].[KeywordTextMatch](@p1Keyword, c.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID


insert into @KeywordResults SELECT -1 as FieldID 
,convert(varchar(max), COinsPercent) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'CoinsPercent' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and [cs].[KeywordPercentMatch](@p1Keyword, a.CoinsPercent, @p2MatchWholeWord) = 1
and c.TableName = 'GPPCoinsGridValues' 
and c.ColumnName = 'CoinsPercent' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'ApplyCoinsToDed' as FieldName  
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where a.rwid = b.rwid 
and c.TableName = 'GPPCoinsGridValues' 
and c.ColumnName = 'ApplyCoinsToDed' 
and v.ValidValueID = a.ApplyCoinsToDed  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1

and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'ApplyCoinsToOOP' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where a.rwid = b.rwid 
and c.TableName = 'GPPCoinsGridValues' 
and c.ColumnName = 'ApplyCoinsToOOP' 
and v.ValidValueID = a.ApplyCoinsToOOP  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,a.Comments as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'Comments' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and c.TableName = 'GPPCoinsGridValues' 
and c.ColumnName = 'Comments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.Comments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 


insert into @KeywordResults SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'HasCoins' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxDoesThisProdHaveCoins' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPCoinsValues' 
and c.ColumnName = 'HasCoins' 
and v.ValidValueID = a.HasCoins  
and  [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'CoinsDifferentForOON' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxCoinsDiffForOON' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPCoinsValues' 
and c.ColumnName = 'CoinsDifferentForOON' 
and v.ValidValueID = a.CoinsDifferentForOON  
and  [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,a.CoinsComments as MatchingText 
,c.Description as LabelText 
,'CoinsComments' as FieldName 
,11 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (11) as ScreenHierarchy 
,'Textbox' as ControlTypeText 
,-1 as ControlTypeID 
,'txtCoinsComments' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'GPPCoinsValues' 
and c.ColumnName = 'CoinsComments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.CoinsComments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 


insert into @KeywordResults SELECT -1 as FieldID 
,convert(varchar(max), CopayDollar) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'CoinsPercent' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCopayRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and [cs].[KeywordDollarMatch](@p1Keyword, a.CopayDollar, @p2MatchWholeWord) = 1
and c.TableName = 'GPPCopayGridValues' 
and c.ColumnName = 'CopayDollar' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,convert(varchar(max), CopayMinDollar) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'CopayMinDollar' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCopayRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and [cs].[KeywordDollarMatch](@p1Keyword, a.CopayMinDollar, @p2MatchWholeWord) = 1
and c.TableName = 'GPPCopayGridValues' 
and c.ColumnName = 'CopayMinDollar' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,convert(varchar(max), CopayMaxDollar) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'CopayMaxDollar' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCopayRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and [cs].[KeywordDollarMatch](@p1Keyword, a.CopayMaxDollar, @p2MatchWholeWord) = 1
and c.TableName = 'GPPCopayGridValues' 
and c.ColumnName = 'CopayMaxDollar' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,a.Comments as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),b.Network + ' - ' + b.RowLabel) as LabelText 
,'Comments' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPCoinsGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and c.TableName = 'GPPCopayGridValues' 
and c.ColumnName = 'Comments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.Comments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 


insert into @KeywordResults SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'HasCopayments' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxDoesThisProdHaveCopay' as ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPCoinsValues' 
and c.ColumnName = 'HasCopayments' 
and v.ValidValueID = a.HasCopayments  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'CopayDifferentForOON' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxCopayDiffForOON' as ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPCopayValues' 
and c.ColumnName = 'CopayDifferentForOON' 
and v.ValidValueID = a.CopayDifferentForOON  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,a.CopayComments as MatchingText 
,c.Description as LabelText 
,'CopayComments' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Textbox' as ControlTypeText 
,-1 as ControlTypeID 
,'txtCopayComments' as ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'GPPCopayValues' 
and c.ColumnName = 'CopayComments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.CopayComments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,a.CopayExclusions as MatchingText 
,c.Description as LabelText 
,'CopayExclusions' as FieldName 
,10 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (10) as ScreenHierarchy 
,'Textbox' as ControlTypeText 
,-1 as ControlTypeID 
,'txtCopayExclusions' as ScreenControlToFind 
FROM [BTB].[CS].[GPPCopayValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'GPPCopayValues' 
and c.ColumnName = 'CopayExclusions' 
and [cs].[KeywordTextMatch](@p1Keyword, a.CopayExclusions, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 





insert into @KeywordResults SELECT -1 as FieldID 
,convert(varchar(max), Amount) as MatchingText 
,FORMATMESSAGE(Replace(Replace(c.Description,'{0}','%s'),'{1}','%s'),b.Network,b.RowLabel) as LabelText 
,'CoinsPercent' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPDedOOPGridMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and [cs].[KeywordDollarMatch](@p1Keyword, a.Amount, @p2MatchWholeWord) = 1
and c.TableName = 'GPPDedOOPGridValues' 
and c.ColumnName = 'Amount' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,a.Comments as MatchingText 
,FORMATMESSAGE(Replace(Replace(c.Description,'{0}','%s'),'{1}','%s'),b.Network,b.RowLabel) as LabelText 
,'Comments' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network) as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPGridValues] a WITH (NOLOCK), 
[BTB].[CS].[GPPCoinsRowMapping] b WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where a.rwid = b.rwid 
and c.TableName = 'GPPDedOOPGridValues' 
and c.ColumnName = 'Comments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.Comments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 




insert into @KeywordResults SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'DoesThisProdHaveDed' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxDoesThisProductHaveDed' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'DoesThisProdHaveDed' 
and v.ValidValueID = a.DoesThisProdHaveDed  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'AreMedRxDedCombined' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxAreMedRxDedCombined' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'AreMedRxDedCombined' 
and v.ValidValueID = a.AreMedRxDedCombined  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'DoesThisProdHaveOOPMax' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxDoesThisProdHaveOOPMax' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'DoesThisProdHaveOOPMax' 
and v.ValidValueID = a.DoesThisProdHaveOOPMax  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'AreINNOONMaxCombined' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxAreINNOONMaxCombined' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'AreINNOONMaxCombined' 
and v.ValidValueID = a.AreINNOONMaxCombined  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'DoesThisProdHaveLifeMax' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxDoesThisProdHaveLifeMax' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'DoesThisProdHaveLifeMax' 
and v.ValidValueID = a.DoesThisProdHaveLifeMax  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,v.ValidValueText as MatchingText 
,c.Description as LabelText 
,'AreAmountsDiffForOON' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Drop Down' as ControlTypeText 
,-1 as ControlTypeID 
,'cbxAreAmountsDiffForOON' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK), 
[BTB].[CS].ValidValues v WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'AreAmountsDiffForOON' 
and v.ValidValueID = a.AreAmountsDiffForOON  
and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
UNION 
SELECT -1 as FieldID 
,a.DedComments as MatchingText 
,c.Description as LabelText 
,'DedComments' as FieldName 
,12 as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (12) as ScreenHierarchy 
,'Textbox' as ControlTypeText 
,-1 as ControlTypeID 
,'txtDedComments' as  ScreenControlToFind 
FROM [BTB].[CS].[GPPDedOOPMValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'GPPDedOOPMValues' 
and c.ColumnName = 'DedComments' 
and [cs].[KeywordTextMatch](@p1Keyword, a.DedComments, @p2MatchWholeWord) = 1
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 




insert into @KeywordResults  SELECT -1 as FieldID 
,CASE WHEN P.ControlType = 'Drop Down' then v.ValidValueText 
ELSE FieldValue 
END as MatchingText 
,c.Description as LabelText 
,p.FieldName 
,d.screenid 
, [CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (d.screenid) as ScreenHierarchy 
,p.ControlType as ControlTypeText 
,-1 as ControlTypeID 
,p.ScreenControlToFind 
FROM BTB.CS.NonDynamicFieldDefs c WITH (NOLOCK), 
BTB.CS.DynamicFieldDefs d WITH (NOLOCK), 
BTB.CS.Screens s, 
BTB.CS.MedBenMValues a WITH (NOLOCK) 
outer apply (values  (N'ServiceInfoBenEffDate','', convert(varchar(max),a.ServiceInfoBenEffDate,101),'Date Control') 
,(N'ServiceInfoBenefitCompletionStatusID','cbxBenefitCompletionStatus', convert(varchar(max),a.ServiceInfoBenefitCompletionStatusID),'Drop Down') 
,(N'ServiceInfoCoveredID','', convert(varchar(max),a.ServiceInfoCoveredID),'Drop Down') 
,(N'ServiceInfoCoveredByID','', convert(varchar(max),a.ServiceInfoCoveredByID),'Drop Down') 
,(N'VendorInfoCoverageDetailsID','', convert(varchar(max),a.VendorInfoCoverageDetailsID),'Drop Down') 
,(N'VendorInfoVendorName','', convert(varchar(max),a.VendorInfoVendorName),'Textbox') 
,(N'VendorInfoInternalVendorContact','', convert(varchar(max),a.VendorInfoInternalVendorContact,101),'Date Control') 
,(N'VendorInfoExternalVendor','', convert(varchar(max),a.VendorInfoExternalVendor),'Textbox') 
,(N'VendorInfoVendorEffDate','', convert(varchar(max),a.VendorInfoVendorEffDate,101),'Date Control') 
,(N'VendorInfoVendorTermDate','', convert(varchar(max),a.VendorInfoVendorTermDate,101),'Date Control') 
,(N'VendorInfoVendorComments','', convert(varchar(max),a.VendorInfoVendorComments),'Textbox') 
,(N'AuthInfoIsThereAWaverPeriodID','', convert(varchar(max),a.AuthInfoIsThereAWaverPeriodID),'Drop Down') 
,(N'AuthInfoAuthWaiverStartDate','', convert(varchar(max),a.AuthInfoAuthWaiverStartDate,101),'Date Control') 
,(N'AuthInfoAuthWaiverEndDate','', convert(varchar(max),a.AuthInfoAuthWaiverEndDate,101),'Date Control') 
,(N'AuthInfoWaverAppliedToID','', convert(varchar(max),a.AuthInfoWaverAppliedToID),'Drop Down') 
,(N'AuthInfoWaiverComments','', convert(varchar(max),a.AuthInfoWaiverComments),'Textbox') 
,(N'AuthInfoGoldStarApplicableID','', convert(varchar(max),a.AuthInfoGoldStarApplicableID),'Drop Down') 
,(N'AuthInfoGoldStarComments','', convert(varchar(max),a.AuthInfoGoldStarComments),'Textbox') 
,(N'AuthInfoGeneralComments','', convert(varchar(max),a.AuthInfoGeneralComments),'Textbox') 
,(N'GPInfoMemberLiabilityID','', convert(varchar(max),a.GPInfoMemberLiabilityID),'Drop Down') 
,(N'GPInfoTotalOOP','', convert(varchar(max),a.GPInfoTotalOOP),'NUMBER') 
,(N'GPInfoLifeTimeMax','', convert(varchar(max),a.GPInfoLifeTimeMax),'NUMBER') 
,(N'GPInfoCopayExceptions','', convert(varchar(max),a.GPInfoCopayExceptions),'Textbox') 
,(N'GPInfoPaymentComments','', convert(varchar(max),a.GPInfoPaymentComments),'Textbox') 
,(N'SettingINNCostShareLoadMethodID','', convert(varchar(max),a.SettingINNCostShareLoadMethodID),'Drop Down') 
,(N'SettingOONRequireDiffInfoID','', convert(varchar(max),a.SettingOONRequireDiffInfoID),'Drop Down') 
,(N'AddBenInfoRules','', convert(varchar(max),a.AddBenInfoRules),'Textbox') 
,(N'AddBenInfoProviderRestrictions','', convert(varchar(max),a.AddBenInfoProviderRestrictions),'Textbox') 
,(N'AddBenInfoBenefitRestrictions','', convert(varchar(max),a.AddBenInfoBenefitRestrictions),'Textbox') 
,(N'AddBenInfoAgeRestrictions','', convert(varchar(max),a.AddBenInfoAgeRestrictions),'Textbox') 
,(N'AddBenInfoGenderRestrictions','', convert(varchar(max),a.AddBenInfoGenderRestrictions),'Textbox') 
,(N'AddBenInfoProcessingRequirements','', convert(varchar(max),a.AddBenInfoProcessingRequirements),'Textbox') 
,(N'AddBenInfoPOSBillTypeImpl','', convert(varchar(max),a.AddBenInfoPOSBillTypeImpl),'Textbox') 
,(N'AddBenInfoBenefitLimitComments','', convert(varchar(max),a.AddBenInfoBenefitLimitComments),'Textbox') 
,(N'AddBenInfoGeneralLimitComments','', convert(varchar(max),a.AddBenInfoGeneralLimitComments),'Textbox') 
,(N'AddBenInfoCCAMComments','', convert(varchar(max),a.AddBenInfoCCAMComments),'Textbox') 
,(N'AddBenInfoBCOComments','', convert(varchar(max),a.AddBenInfoBCOComments),'Textbox'))  P (FieldName, ScreenControlToFind, FieldValue, ControlType) 
left outer join BTB.CS.ValidValues v on convert(varchar(max),v.validvalueid) = p.FieldValue and p.ControlType = 'Drop Down' 

where a.MemberGroupID = @p3MemberGroupID  
and a.PlanID = @p4PlanID 
and ( 
(p.ControlType = 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1 ) or 
(p.ControlType != 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 )  
) 
and d.FieldID = a.FieldID 
and c.TableName = 'MedBenMValues' 
and c.ColumnName = p.FieldName 
and s.ScreenID = d.ScreenID 
order by s.ScreenOrder, LabelText 






insert into @KeywordResults SELECT -1 as FieldID 
,a.VendorName as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),convert(varchar(max),a.RwID)) as LabelText 
,'VendorName' as FieldName 
,a.ScreenID as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (a.ScreenID) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,'dgVendorHistory' as  ScreenControlToFind 
FROM [BTB].[CS].[MedBenVendorHistoryGridValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'MedBenVendorHistoryGridValues' 
and [cs].[KeywordTextMatch](@p1Keyword, a.VendorName, @p2MatchWholeWord) = 1
and c.ColumnName = 'VendorName' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,convert(varchar(max),a.[EffDate],101) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),convert(varchar(max),a.RwID)) as LabelText 
,'EffDate' as FieldName 
,a.ScreenID as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (a.ScreenID) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,'dgVendorHistory' as  ScreenControlToFind 
FROM [BTB].[CS].[MedBenVendorHistoryGridValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'MedBenVendorHistoryGridValues' 
and [cs].[KeywordDateMatch](@p1Keyword, a.EffDate, @p2MatchWholeWord) = 1
and c.ColumnName = 'EffDate' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 
union 
SELECT -1 as FieldID 
,convert(varchar(max),a.[TermDate],101) as MatchingText 
,FORMATMESSAGE(Replace(c.Description,'{0}','%s'),convert(varchar(max),a.RwID)) as LabelText 
,'TermDate' as FieldName 
,a.ScreenID as ScreenID 
,[CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (a.ScreenID) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,'dgVendorHistory' as  ScreenControlToFind 
FROM [BTB].[CS].[MedBenVendorHistoryGridValues] a WITH (NOLOCK), 
[BTB].[CS].NonDynamicFieldDefs c WITH (NOLOCK) 
where c.TableName = 'MedBenVendorHistoryGridValues' 
and [cs].[KeywordDateMatch](@p1Keyword, a.TermDate, @p2MatchWholeWord) = 1
and c.ColumnName = 'TermDate' 
and a.MemberGroupID = @p3MemberGroupID 
and a.PlanID = @p4PlanID 





insert into @KeywordResults  SELECT -1 as FieldID 
,CASE WHEN P.ControlType = 'Drop Down' then v.ValidValueText 
ELSE FieldValue 
END as MatchingText 
,FORMATMESSAGE(Replace(Replace(c.Description,'{0}','%s'),'{1}','%s'),b.Network,b.RowLabelText) as LabelText 
,p.FieldName 
,d.screenid 
, [CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (d.screenid) as ScreenHierarchy 
,p.ControlType as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network + 'CostShare') as  ScreenControlToFind 
FROM BTB.CS.NonDynamicFieldDefs c WITH (NOLOCK), 
BTB.CS.DynamicFieldDefs d WITH (NOLOCK), 
BTB.CS.Screens s, 
BTB.CS.MedBenSettingsGridMainRowMapping b, 
BTB.CS.MedBenSettingsGridMainValues a WITH (NOLOCK) 
outer apply (values                      (N'Home','', convert(varchar(max),a.Home),'Grid Cell') 
,(N'ProfSvcs','', convert(varchar(max),a.ProfSvcs),'Grid Cell') 
,(N'Other','', convert(varchar(max),a.Other),'Grid Cell') 
,(N'OutpFac','', convert(varchar(max),a.OutpFac),'Grid Cell') 
,(N'InptFac','', convert(varchar(max),a.InptFac),'Grid Cell'))  P (FieldName, ScreenControlToFind, FieldValue, ControlType) 
left outer join BTB.CS.ValidValues v on convert(varchar(max),v.validvalueid) = p.FieldValue and p.ControlType = 'Drop Down' 

where a.MemberGroupID = @p3MemberGroupID  
and a.PlanID = @p4PlanID 
and ( 
(p.ControlType = 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1 ) or 
(p.ControlType != 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 )  
) 
and d.FieldID = a.FieldID 
and c.TableName = 'MedBenSettingsGridMainValues' 
and c.ColumnName = p.FieldName 
and b.RwID = a.RwID 
and s.ScreenID = d.ScreenID 
order by s.ScreenOrder, LabelText 





insert into @KeywordResults  SELECT -1 as FieldID 
,CASE WHEN P.ControlType = 'Drop Down' then v.ValidValueText 
ELSE FieldValue 
END as MatchingText 
,FORMATMESSAGE(Replace(Replace(c.Description,'{0}','%s'),'{1}','%s'),b.Network,b.RowLabelText) as LabelText 
,p.FieldName 
,d.screenid 
, [CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (d.screenid) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,('dg' + b.Network + 'CostShare2') as  ScreenControlToFind 
FROM BTB.CS.NonDynamicFieldDefs c WITH (NOLOCK), 
BTB.CS.DynamicFieldDefs d WITH (NOLOCK), 
BTB.CS.Screens s, 
BTB.CS.MedBenSettingsGridOtherRowMapping b, 
BTB.CS.MedBenSettingsGridOtherValues a WITH (NOLOCK) 
outer apply (values                      (N'Home','', convert(varchar(max),a.Home), CASE WHEN a.RWID in (4,8) then 'Textbox' else 'Drop Down' END) 
,(N'ProfSvcs','', convert(varchar(max),a.ProfSvcs),CASE WHEN a.RWID in (4,8) then 'Textbox' else 'Drop Down' END) 
,(N'Other','', convert(varchar(max),a.Other),CASE WHEN a.RWID in (4,8) then 'Textbox' else 'Drop Down' END) 
,(N'OutpFac','', convert(varchar(max),a.OutpFac),CASE WHEN a.RWID in (4,8) then 'Textbox' else 'Drop Down' END) 
,(N'InptFac','', convert(varchar(max),a.InptFac),CASE WHEN a.RWID in (4,8) then 'Textbox' else 'Drop Down' END))  P (FieldName, ScreenControlToFind, FieldValue, ControlType) 
left outer join BTB.CS.ValidValues v on convert(varchar(max),v.validvalueid) = p.FieldValue and p.ControlType = 'Drop Down' 

where a.MemberGroupID = @p3MemberGroupID  
and a.PlanID = @p4PlanID 
and ( 
(p.ControlType = 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1 ) or 
(p.ControlType != 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 )  
) 
and d.FieldID = a.FieldID 
and c.TableName = 'MedBenSettingsGridOtherValues' 
and c.ColumnName = p.FieldName 
and b.RwID = a.RwID 
and s.ScreenID = d.ScreenID 
order by s.ScreenOrder, LabelText 






insert into @KeywordResults  SELECT -1 as FieldID 
,CASE WHEN P.ControlType = 'Drop Down' then v.ValidValueText 
ELSE FieldValue 
END as MatchingText 
,'Benefit Links - ' + FORMATMESSAGE(Replace(c.Description,'{0}','%s'),convert(varchar(max),a.LinkID)) as LabelText 
,p.FieldName 
,d.screenid 
, [CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (d.screenid) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,'dgBenefitLinks' as  ScreenControlToFind 
FROM BTB.CS.NonDynamicFieldDefs c WITH (NOLOCK), 
BTB.CS.DynamicFieldDefs d WITH (NOLOCK), 
BTB.CS.MedBenMValues b WITH (NOLOCK), 
BTB.CS.Screens s, 
BTB.CS.GeneralLinks a WITH (NOLOCK) 
outer apply (values                      (N'EffDt','', convert(varchar(max),Convert(date,a.EffDt),101), 'Date Control') 
,(N'TermDt','', convert(varchar(max),Convert(date,a.TermDt),101),'Date Control') 
,(N'LinkStatusID','', convert(varchar(max),a.LinkStatusID),'Drop Down') 
,(N'LinkName','', a.LinkName,'Textbox') 
,(N'URL','', a.URL,'Textbox') 
,(N'Comments','', a.Comments,'Textbox'))  P (FieldName, ScreenControlToFind, FieldValue, ControlType) 
left outer join BTB.CS.ValidValues v on convert(varchar(max),v.validvalueid) = p.FieldValue and p.ControlType = 'Drop Down' 

where a.MemberGroupID = @p3MemberGroupID  
and a.PlanID = @p4PlanID 
and b.MemberGroupID = a.MemberGroupID 
and b.PlaniD = a.PlanID 
and ( 
(p.ControlType = 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1 ) or 
(p.ControlType = 'Date Control' and [cs].[KeywordDateMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 ) or  
(p.ControlType not in ('Drop Down', 'Date Control') and [cs].[KeywordTextMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 )  
) 
and d.FieldID = b.FieldID 
and c.TableName = 'GeneralLinks' 
and c.ColumnName = p.FieldName 
and s.ScreenID = d.ScreenID 
and a.ScreenID = d.ScreenID 
order by s.ScreenOrder, LabelText 






insert into @KeywordResults  SELECT -1 as FieldID 
,CASE WHEN P.ControlType = 'Drop Down' then v.ValidValueText 
ELSE FieldValue 
END as MatchingText 
,'Benefit Limits and Codes - ID ' + convert(varchar(max),a.LCID) + ' - ' + P.FieldName as LabelText 
,p.FieldName 
,d.screenid 
, [CS].[GET_COMBINED_NAME_FOR_SCREEN_ID] (d.screenid) as ScreenHierarchy 
,'Grid Cell' as ControlTypeText 
,-1 as ControlTypeID 
,'dgLimitsAndCodes' as  ScreenControlToFind 
FROM BTB.CS.DynamicFieldDefs d WITH (NOLOCK), 
BTB.CS.MedBenMValues b WITH (NOLOCK), 
BTB.CS.Screens s, 
BTB.CS.LimitsAndCodes a WITH (NOLOCK) 
outer apply (values                      (N'Status','', convert(varchar(max),a.StatusID), 'Drop Down') 
,(N'Status Eff Dt','', convert(varchar(max),Convert(date,a.StatusEffectiveDate),101),'Date Control') 
,(N'Category Description','', a.CategoryDescription,'Textbox') 
,(N'SubCategory Description','', a.SubCategoryDescription,'Textbox') 
,(N'Name of Product/Waiver','', a.ProductWaiverName,'Textbox') 
,(N'Diagnosis Codes','', a.DiagnosisCodes,'Textbox') 
,(N'Revenue Codes','', a.RevenueCodes,'Textbox') 
,(N'Procedure Codes','', a.ProcedureCodes,'Textbox') 
,(N'Modifiers','', a.Modifiers,'Textbox') 
,(N'Code Related Comments','', a.CodeRelatedComments,'Textbox') 
,(N'Place of Service/Bill Type Requirements','', a.POSRestrictions,'Textbox') 
,(N'Limit Quantity','', convert(varchar(max),a.LimitQuantity),'Textbox') 
,(N'Limit Type','', a.LimitType,'Textbox') 
,(N'Per','', a.Per,'Textbox') 
,(N'Limit Amount','', convert(varchar(max),a.LimitAmount),'Textbox') 
,(N'Limit Timeframe','', a.LimitTimeframe,'Textbox') 
,(N'Physician Or FacilityRestrictions','', convert(varchar(max),a.PhysicianOrFacilityRestrictionsID),'Drop Down') 
,(N'Low Age','', convert(varchar(max),a.LowAge),'Textbox') 
,(N'High Age','', convert(varchar(max),a.HighAge),'Textbox') 
,(N'Gender','', a.Gender,'Textbox') 
,(N'Comments','', a.Comments,'Textbox'))  P (FieldName, ScreenControlToFind, FieldValue, ControlType) 
left outer join BTB.CS.ValidValues v on convert(varchar(max),v.validvalueid) = p.FieldValue and p.ControlType = 'Drop Down' 

where a.MemberGroupID = @p3MemberGroupID  
and a.PlanID = @p4PlanID 
and b.MemberGroupID = a.MemberGroupID 
and b.PlaniD = a.PlanID 
and ( 
(p.ControlType = 'Drop Down' and [cs].[KeywordTextMatch](@p1Keyword, v.ValidValueText, @p2MatchWholeWord) = 1 ) or 
(p.ControlType = 'Date Control' and [cs].[KeywordDateMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 ) or  
(p.ControlType not in ('Drop Down', 'Date Control') and [cs].[KeywordTextMatch](@p1Keyword, p.FieldValue, @p2MatchWholeWord) = 1 )  
) 
and d.FieldID = b.FieldID 
and s.ScreenID = d.ScreenID 
and a.ScreenID = d.ScreenID 
order by s.ScreenOrder, LabelText 



Select * from @KeywordResults



GO
/****** Object:  StoredProcedure [CS].[SP_ProductSearch]    Script Date: 9/10/2021 3:22:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [CS].[SP_ProductSearch]    
 @pBtbGroupId bigint =0,    --Plans.membergroupid
 @pBtbProductId bigint =0,    --Plans.planId
    
 @pProductId nvarchar(4000) = null,    --a.FieldID = 16
 @pSubGroupId nvarchar(4000) = null,  --a.FieldID = 17   
 @pGroupId nvarchar(4000) = null,    -- b.FieldID = 12
 @pProductDescription nvarchar(4000) = null,    --a.FieldID = 15  and a.[FieldValue] like @p5
 @pGroupDescription nvarchar(4000) = null,    --b.FieldID = 3   and  b.[FieldValue] like @p6      
 @pHealthPlanName nvarchar(4000) = null,    --Plans.[Name] like @p7
 @pProductCategory nvarchar(4000) = null,  --a.FieldID = 74 and (a.FieldValue IS NULL or  a.FieldValue like @p8  
 @pProductType INT = 0,    --a.FieldID = 13
 @pCcamOwner INT = 0,    --a.FieldID in (58,59,60) and a.FieldValue = @p10
 @pEffStartDate Date = NULL,    --a.FieldID = 14 
 @pEffEndDate Date = NULL,    --a.FieldID = 14 
 @pTermStartDate Date = NULL,    --a.FieldID = 20
 @pTermEndDate Date = NULL,    --a.FieldID = 20
 @pDTO nvarchar(6) = '+00:00',    --
 @pDeleted nvarchar(1) = 'N',    
 @pExcluded bit = 1,  --(a.FieldID = 34 ) and (a.FieldValue is null or a.FieldValue != '980')
 @pRowStart  int = 0,  
 @pRowEnd int = 500  
 AS    

 if @pEffStartDate is null
 begin
 set @pEffStartDate = cast('01/01/1900' as datetime)
 end  
 if @pEffEndDate is null
 begin
 set @pEffEndDate = cast('12/31/9999' as datetime)
 end  
 if @pTermStartDate is null
 begin
 set @pTermStartDate = cast('01/01/1900' as datetime)
 end  
 if @pTermEndDate is null
 begin
 set @pTermEndDate = cast('12/31/9999' as datetime)
 end 


 SELECT ROW_NUMBER() OVER (Order By   A.MemberGroupID  ,A.PlanID   ,A.ProductID ,
A.SubGroupID   ,A.ProductCategory,A.ProductTypeID  ,A.GroupID,
A.ProductDescription   ,A.GroupDescription   ,A.HealthPlan   ,CCAMOwner1ID  ,A.EffectiveDate ,
A.CancelDate   ,A.ModifiedDate  ,A.CreateDate  ,A.CustomerID) AS RowNumber ,A.*  
	 into #ProductSearchResults
FROM ( 
	 select z.* ,ptvv.ValidValueText as ProductTypeText
from 
 (select piv.MemberGroupID  
	,piv.PlanID  
	,piv.ProductID  
	,piv.SubGroupID  
	,piv.GroupID  
	,piv.ProductDescription  
	,piv.GroupDescription  
	,piv.HealthPlan  
	,Convert(int,piv.CCAMOwner1ID) as CCAMOwner1ID 
	,piv.ProductCategory as ProductCategory 
	,Convert(int,piv.ProductTypeID) as ProductTypeID
	,u.LastName + ', ' +  u.Firstname + ' - ' + upper(u.LoginName) as CCAMOwner1 
	,Convert(Date,piv.EffectiveDate) as EffectiveDate  
	,Convert(Date,piv.CancelDate) as CancelDate  
	,Cast(switchoffset(TODATETIMEOFFSET(PIV.ModifiedDate, '+00:00'), @pDTO) as datetime) as ModifiedDate 
	,Cast(switchoffset(TODATETIMEOFFSET(PIV.CreateDate, '+00:00'), @pDTO) as datetime) as CreateDate 
	,PIV.Deleted, CASE WHEN PIV.Deleted='Y' Then 'Yes' ELSE 'No' END as DeletedText 
	,PIV.CustomerID 
	, '' as ProductCategoryText
 from  
		  (select m.MemberGroupID  
	,a.PlanID  
	,a.FieldValue  
	,m.CustomerID  
	,dfv3.FieldValue as GroupDescription 
	,dfv34.FieldValue as Excluded 
	,c.Name as HealthPlan  

   ,CASE  
	   WHEN a.FieldID = 16 then 'ProductID'  
	   WHEN a.FieldID = 17 then 'SubGroupID'  
	   WHEN a.FieldID = 12 then 'GroupID'  
	   WHEN a.FieldID = 15 then 'ProductDescription'  
	   WHEN a.FieldID = 14 then 'EffectiveDate'  
	   WHEN a.FieldID = 20 then 'CancelDate'  
	   WHEN a.FieldID = 58 then 'CCAMOwner1ID' 
	   WHEN a.FieldID = 74 then 'ProductCategory' 
	   WHEN a.FieldID = 13 then 'ProductTypeID' 
	END as FieldName  ,
	p.ModifiedDate,
	p.CreateDate,
	p.Deleted
 from  
btb.cs.MemberGroups m
join btb.cs.dynamicfieldvalues a on a.fieldId in (16, 17, 12, 15, 14, 20,58,74,13) and a.MemberGroupID = m.MemberGroupID
join btb.cs.dynamicfieldvalues dfv3 on dfv3.PlanID = -1    and dfv3.FieldID = 3  and dfv3.MemberGroupID = m.MemberGroupID
join btb.cs.Customers c on c.CustomerID = m.CustomerID
join btb.cs.Plans p on p.PlanID = a.PlanID
left outer join btb.cs.DynamicFieldValues dfv34 on dfv34.PlanID = p.PlanID  and dfv34.FieldID = 34 and dfv34.MemberGroupID = m.MemberGroupID
where                    
 (@pExcluded is null 
	or @pExcluded = 0
	or (@pExcluded = 1 and (dfv34.FieldValue is null or dfv34.FieldValue != '980')))
) d  
 pivot  
 (  
 max(FieldValue)  
 for FieldName in (ProductID,  
		SubGroupID,  
		GroupID,  
		ProductDescription,  
		EffectiveDate,  
		CancelDate, 
		ProductCategory, 
		ProductTypeID, 
		CCAMOwner1ID)) piv 
 
 left outer join btb.cs.[Users] U WITH (NOLOCK) ON U.UserID = PIV.CCAMOwner1ID 
 where 
 (@pBtbGroupId <= 0 or piv.MemberGroupID = @pBtbGroupId)
 and (@pBtbProductId <= 0 or piv.PlanID = @pBtbProductId)
 and (@pProductId is null or piv.ProductID like @pProductId)
 and (@pSubGroupId is null or piv.SubGroupID like @pSubGroupId)
 and (@pGroupId is null or piv.GroupID like @pGroupId)
 and (@pProductDescription is null or piv.ProductDescription like @pProductDescription)
 and (@pGroupDescription is null or piv.GroupDescription like @pGroupDescription)
 and (@pHealthPlanName is null or piv.HealthPlan like @pHealthPlanName)
 and (@pProductCategory is null or piv.ProductCategory like @pProductCategory)
 and (@pProductType is null or @pProductType <= 0 or piv.ProductTypeID = @pProductType)
 and (@pCcamOwner is null or @pCcamOwner <= 0 or piv.CCAMOwner1ID = @pCcamOwner)
 and piv.EffectiveDate between @pEffStartDate and @pEffEndDate
 and (piv.CancelDate is null or piv.CancelDate between @pTermStartDate and @pTermEndDate)
 and (@pDeleted is null or @pDeleted != 'N' or piv.Deleted = @pDeleted)
 ) z
 left outer join btb.cs.ValidValues ptvv on ptvv.ValidValueTypeID = 245  and ptvv.ValidValueID = cast(isnull(ltrim(rtrim(z.ProductTypeID)), '-1') as int)
 ) a


Select (select COUNT(*) FROM #ProductSearchResults) AS TotalRows, * FROM #ProductSearchResults     
WHERE RowNumber BETWEEN @pRowStart and @pRowEnd
ORDER BY RowNumber    


GO


begin Transaction
Insert Into CS.ValidValues
	(ValidValueID,ValidValueTypeID,ValidValueText, ValidValueOrder, IsUnanswered)
	values  
		(1641,257, '[Select One]',1,'Y'),
		(1642,258, '[Select One]',1,'Y'),
		(1505,245,'Individual Exchanges (IEX)',16,'N')
GO
--UPDATES
UPDATE [CS].[DynamicFieldDefs] Set ScreenOrder = 8 WHERE FieldID = 6 
UPDATE [CS].[DynamicFieldDefs] Set ScreenOrder = 9 WHERE FieldID = 7 

--INSERT
SET IDENTITY_INSERT [CS].[DynamicFieldDefs] ON 

INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1443, 1, N'CSP Group GoLive Date', 812, 8, CAST(N'2021-06-25T09:34:09.5470000+00:00' AS DateTimeOffset), 1, CAST(N'2021-06-25T09:34:09.5470000+00:00' AS DateTimeOffset), 1, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1444, 1, N'Termination Date', 812, 9, CAST(N'2021-06-25T09:34:09.5470000+00:00' AS DateTimeOffset), 1, CAST(N'2021-06-25T09:34:09.5470000+00:00' AS DateTimeOffset), 1, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1551, 546, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1552, 547, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1553, 548, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1554, 549, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1555, 550, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1556, 551, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1557, 552, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1558, 553, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1559, 554, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1560, 555, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1561, 556, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1562, 557, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1563, 558, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1564, 559, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1565, 560, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1566, 561, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1567, 562, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1568, 563, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1569, 564, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1570, 565, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1571, 566, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1572, 567, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1573, 568, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1574, 569, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
GO
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1575, 570, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1576, 571, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1577, 572, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1578, 573, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1579, 574, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1580, 575, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1581, 576, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1582, 577, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1583, 578, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1584, 579, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1585, 580, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1586, 581, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1587, 582, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1588, 583, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1589, 584, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1590, 585, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1591, 586, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1592, 587, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1593, 588, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1594, 589, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1595, 590, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1596, 591, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1597, 592, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1598, 593, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1599, 594, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1600, 595, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1601, 596, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1602, 597, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1603, 598, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1604, 599, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1605, 600, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1606, 601, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1607, 602, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1608, 603, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1609, 604, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1610, 605, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1611, 606, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1612, 607, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
--INSERTS
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1613, 608, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1614, 609, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1615, 610, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1616, 611, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1617, 612, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1618, 613, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1619, 614, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1620, 615, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1621, 616, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1622, 617, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1623, 618, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1624, 619, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1625, 620, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1626, 621, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1627, 622, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1628, 623, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1629, 624, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1630, 625, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1631, 626, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1632, 627, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1633, 628, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
INSERT [CS].[DynamicFieldDefs] ([FieldID], [ScreenID], [FieldName], [ControlType], [ScreenOrder], [CreateDate], [CreatedBy], [LastUpdateDate], [LastUpdateBy], [ClonedFieldID]) VALUES (1634, 629, N'Medical Benefit Control', 1548, 1, NULL, 1, NULL, NULL, -1)
SET IDENTITY_INSERT [CS].[DynamicFieldDefs] OFF 

--INSERT
INSERT [CS].[DynamicFieldProperties] ([FieldID], [PropertyType], [PropertyValue]) VALUES (1443, 792, N'CSP Group Go-Live Date:')
INSERT [CS].[DynamicFieldProperties] ([FieldID], [PropertyType], [PropertyValue]) VALUES (1444, 792, N'Termination Date:')

--INSERT
SET IDENTITY_INSERT [CS].[GppMedCostShareRowMapping] ON 

INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (1, N'Abortion', 1)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (2, N'Acupuncture', 2)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (3, N'Allergy Testing', 3)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (4, N'Bariatric Surgery', 5)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (5, N'Mental Health Care and Substance-Related and Addictive Disorders Services - Inpatient', 37)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (6, N'Mental Health Care and Substance-Related and Addictive Disorders Services - Outpatient', 39)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (8, N'Mental Health Care and Substance-Related and Addictive Disorders Services - Office Visit', 38)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (9, N'Chemotherapy', 6)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (10, N'Chiropractic Care', 7)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (11, N'Cosmetic Surgery', 8)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (12, N'Delivery and All Inpatient Services for Maternity Care', 9)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (13, N'Dental: Basic Dental Care for Children', 11)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (14, N'Dental: Preventive Dental Care for Children', 16)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (15, N'Dental: Orthodontia for Children', 15)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (16, N'Dental: Basic Dental Services for Adults', 12)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (17, N'Diabetes Services', 18)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (18, N'Dialysis', 19)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (19, N'Durable Medical Equipment', 20)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (20, N'Emergency Health Care Services - Outpatient', 21)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (21, N'Ambulance Services', 4)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (22, N'Habilitative Services', 24)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (23, N'Hearing Aids', 25)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (24, N'Home Health Care', 26)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (25, N'Hospice Care', 27)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (26, N'Major Diagnostic and Imaging - Office/Free-Standing Facility Based', 35)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (27, N'Major Diagnostic and Imaging - Outpatient Hospital Based', 36)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (28, N'Infertility', 29)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (29, N'Infusion Therapy', 30)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (30, N'Hospital - Inpatient Stay', 28)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (31, N'Inpatient Physician and Surgical Services', 31)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (32, N'Laboratory Outpatient and Professional Services - Office / Free-Standing Facility Based', 32)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (33, N'Laboratory Outpatient and Professional Services -Outpatient Hospital Based', 33)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (34, N'Long-Term/Custodial Nursing Home Care', 34)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (35, N'Nutritional Counseling', 40)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (36, N'Other Practitioner Office Visit (Nurse, Physician Assistant)', 41)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (37, N'Outpatient Facility Fee (e.g., Ambulatory Surgery Center) - Office / Free-Standing Facility Based', 42)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (38, N'Outpatient Facility Fee (e.g., Ambulatory Surgery Center) - Outpatient Hospital Based', 43)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (39, N'Outpatient Rehabilitation Services', 44)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (40, N'Outpatient Surgery Physician/Surgical Services - Office / Free-Standing Facility Based', 45)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (41, N'Outpatient Surgery Physician/Surgical Services - Outpatient Hospital Based', 46)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (42, N'Pharmacy: Non-Preferred Generic (Tier 2)', 53)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (43, N'Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', 55)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (44, N'Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', 54)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (45, N'Pharmacy: Preferred Generic (Tier 1)', 52)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (46, N'Pharmacy: Specialty Drugs (Tier 5)', 56)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (47, N'Prenatal and Postnatal Care', 59)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (48, N'Preventive Care Services', 60)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (49, N'Physician Office Services (PCP)', 57)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (50, N'Private Duty Nursing', 61)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (51, N'Prosthetic Devices', 62)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (52, N'Radiation', 63)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (53, N'Reconstructive Surgery', 64)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (54, N'Rehabilitative Occupational and Rehabilitative Physical Therapy', 65)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (55, N'Rehabilitative Speech Therapy', 66)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (56, N'Foot Care', 23)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (57, N'Skilled Nursing Facility/Inpatient', 67)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (58, N'Specialist Visit', 68)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (59, N'Transplantation Services', 70)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (60, N'Temporomandibular Joint Syndrome (TMJ)', 69)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (61, N'Urgent Care Center Services', 71)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (62, N'Vendor Virtual Care Services', 72)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (63, N'Vision: Eyewear Frames for Children (Tiers 1-5)', 77)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (65, N'Vision: Low Vision Therapy for Children', 79)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (67, N'Vision: Routine Eye Exams for Adults', 80)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (69, N'Vision: Routine Eye Exam for Children', 81)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (71, N'Weight Loss Programs', 82)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (73, N'X-rays and Diagnostic Imaging - Freestanding', 83)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (74, N'Dental: Anesthesia', 10)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (75, N'Enteral Nutrition', 22)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (76, N'Pregnancy - Maternity Services', 58)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (77, N'Vision: Contacts for Adults', 73)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (78, N'X-rays and Diagnostic Imaging - Hospital Setting', 84)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (79, N'Dental: Major Dental Care for Children', 13)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (80, N'Dental: Major Dental Services for Adults', 14)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (81, N'Dental: Preventive Dental Services for Adults', 17)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (82, N'Preferred Pharmacy: Preferred Generic (Tier 1)', 47)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (83, N'Preferred Pharmacy: Non-Preferred Generic (Tier 2)', 48)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (84, N'Preferred Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', 49)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (85, N'Preferred Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', 50)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (86, N'Preferred Pharmacy: Specialty Drugs (Tier 5)', 51)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (87, N'Vision: Eyewear Frames for Adults (Tier 1)', 74)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (88, N'Vision: Eyewear Lenses for Adults', 75)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (89, N'Vision: Contacts for Children', 76)
INSERT [CS].[GppMedCostShareRowMapping] ([RwID], [RowLabel], [OrderNum]) VALUES (90, N'Vision: Eyewear Lenses for Children', 78)
SET IDENTITY_INSERT [CS].[GppMedCostShareRowMapping] OFF

INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (163, N'GppMedCostShareValues', N'Comments', N'CostShare Comments')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (164, N'GppMedCostShareValues', N'Exclusions', N'CostShare Exclusions')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (165, N'GppMedCostShareGridValues', N'CopayDollar', N'{0} - Copay')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (166, N'GppMedCostShareGridValues', N'CoinsPercent', N'{0} - Coins Percent')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (167, N'GppMedCostShareGridValues', N'ApplyCoinsToDed', N'{0} - Ded Applies')
GO
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (168, N'GppMedCostShareGridValues', N'AreMedRxDedCombined', N'{0} - Med/Rx Ded Combined')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (169, N'GppMedCostShareGridValues', N'MedInnIndDed', N'{0} - Med INN Individual Ded Applies')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (170, N'GppMedCostShareGridValues', N'MedInnFamDed', N'{0} - Med INN Family Ded Applies')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (171, N'GppMedCostShareGridValues', N'MedInnIndOopm', N'{0} - Med INN Ind OOPM')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (172, N'GppMedCostShareGridValues', N'MedInnFamOopm', N'{0} - Med INN Family OOPM')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (173, N'GppMedCostShareGridValues', N'Comments', N'{0} - Comments')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (174, N'MemberGroupCSPProducts', N'CSPProductDesc', N'{0} - Cost Share Product Description')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (175, N'MemberGroupCSPProducts', N'StatusID', N'{0} - Status')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (176, N'MemberGroupCSPProducts', N'StatusEffectiveDate', N'{0} - Effective Date')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (177, N'MedBenMValues', N'AddBenInfoBCCSServiceIDs', N'BCCS Service ID(s) (Internal Use Only)')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (178, N'MedBenMValues', N'AddBenInfoBCCSServiceRule', N'BCCS Service Rule (Internal Use Only)')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (179, N'MedBenMValues', N'BenSummInfoMemberGeneralInfo', N'Member/General Information')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (180, N'MedBenMValues', N'BenSummInfoProviderInfo', N'Provider Information')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (181, N'MedBenMValues', N'MyUHCSummInfoMemberGeneralInfo', N'Member/General Information')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (182, N'GppMedCostShareProductSettings', N'HasLifetimeMax', N'{0} - HasLifetimeMax')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (183, N'GppMedCostShareProductSettings', N'LifetimeMaxAmount', N'{0} - LifetimeMaxAmount')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (184, N'GppMedCostShareProductSettings', N'IsProductGated', N'{0} - IsProductGated')
INSERT [CS].[NonDynamicFieldDefs] ([FieldID], [TableName], [ColumnName], [Description]) VALUES (185, N'GppMedCostShareGridValues', N'DoesDeductibleApply', N'{0} - Ded Applies')

INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (19, 2, N'CSP Products', 19, N'300', N'N', N'N', N'N', NULL)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (546, 3, N'Abortion', 313, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (547, 3, N'Acupuncture', 314, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (548, 3, N'Allergy Testing', 315, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (549, 3, N'Ambulance Services', 316, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (550, 3, N'Bariatric Surgery', 317, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (551, 3, N'Chemotherapy', 318, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (552, 3, N'Chiropractic Care', 319, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (553, 3, N'Cosmetic Surgery', 320, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (554, 3, N'Delivery and All Inpatient Services for Maternity Care', 321, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (555, 3, N'Dental: Anesthesia', 322, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (556, 3, N'Dental: Basic Dental Care for Children', 323, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (557, 3, N'Dental: Preventive Dental Care for Children', 328, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (558, 3, N'Dental: Orthodontia for Children', 327, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (559, 3, N'Dental: Basic Dental Services for Adults', 324, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (560, 3, N'Diabetes Services', 330, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (561, 3, N'Dialysis', 331, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (562, 3, N'Durable Medical Equipment', 332, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (563, 3, N'Emergency Health Care Services - Outpatient', 333, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (564, 3, N'Enteral Nutrition', 334, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (565, 3, N'Foot Care', 335, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (566, 3, N'Habilitative Services', 336, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (567, 3, N'Hearing Aids', 337, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (568, 3, N'Home Health Care', 338, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (569, 3, N'Hospice Care', 339, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (570, 3, N'Hospital - Inpatient Stay', 340, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (571, 3, N'Infertility', 341, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (572, 3, N'Infusion Therapy', 342, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (573, 3, N'Inpatient Physician and Surgical Services', 343, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (574, 3, N'Laboratory Outpatient and Professional Services - Office / Free - Standing Facility Based', 344, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (575, 3, N'Laboratory Outpatient and Professional Services - Outpatient Hospital Based', 345, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (576, 3, N'Long - Term / Custodial Nursing Home Care', 346, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (577, 3, N'Major Diagnostic and Imaging - Office / Free - Standing Facility Based', 347, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (578, 3, N'Major Diagnostic and Imaging - Outpatient Hospital Based', 348, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (579, 3, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Inpatient', 349, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (580, 3, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Office Visit', 350, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (581, 3, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Outpatient', 351, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (582, 3, N'Nutritional Counseling', 352, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (583, 3, N'Other Practitioner Office Visit(Nurse, Physician Assistant)', 353, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (584, 3, N'Outpatient Facility Fee(e.g., Ambulatory Surgery Center) - Office / Free - Standing Facility Based', 354, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (585, 3, N'Outpatient Facility Fee(e.g., Ambulatory Surgery Center) - Outpatient Hospital Based', 355, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (586, 3, N'Outpatient Rehabilitation Services', 356, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (587, 3, N'Outpatient Surgery Physician / Surgical Services - Office / Free - Standing Facility Based', 357, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (588, 3, N'Outpatient Surgery Physician / Surgical Services - Outpatient Hospital Based', 358, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (589, 3, N'Pharmacy: Non-Preferred Generic (Tier 2)', 365, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (590, 3, N'Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', 367, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (591, 3, N'Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', 366, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (592, 3, N'Pharmacy: Preferred Generic (Tier 1)', 364, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (593, 3, N'Pharmacy: Specialty Drugs (Tier 5)', 368, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (594, 3, N'Physician Office Services (PCP)', 369, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (595, 3, N'Pregnancy - Maternity Services', 370, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (596, 3, N'Prenatal and Postnatal Care', 371, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (597, 3, N'Preventive Care Services', 372, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (598, 3, N'Private Duty Nursing', 373, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (599, 3, N'Prosthetic Devices', 374, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (600, 3, N'Radiation', 375, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (601, 3, N'Reconstructive Surgery', 376, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (602, 3, N'Rehabilitative Occupational and Rehabilitative Physical Therapy', 377, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (603, 3, N'Rehabilitative Speech Therapy', 378, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (604, 3, N'Skilled Nursing Facility / Inpatient', 379, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (605, 3, N'Specialist Visit', 380, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (606, 3, N'Vision: Contacts for Adults', 385, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (607, 3, N'Transplantation Services', 381, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (608, 3, N'Temporomandibular Joint Syndrome(TMJ)', 382, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (609, 3, N'Urgent Care Center Services', 383, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (610, 3, N'Vendor Virtual Care Services', 384, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (611, 3, N'Vision: Eyewear Frames for Children (Tiers 1-5)', 389, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (612, 3, N'Vision: Low Vision Therapy for Children', 391, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (613, 3, N'Vision: Routine Eye Exams for Adults', 393, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (614, 3, N'Vision: Routine Eye Exam for Children', 392, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (615, 3, N'Weight Loss Programs', 394, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (616, 3, N'X - rays and Diagnostic Imaging - Freestanding', 395, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (617, 3, N'X - rays and Diagnostic Imaging - Hospital Setting', 396, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (618, 3, N'Dental: Major Dental Care for Children', 325, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (619, 3, N'Dental: Major Dental Services for Adults', 326, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (620, 3, N'Dental: Preventive Dental Services for Adults', 329, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (621, 3, N'Preferred Pharmacy: Preferred Generic (Tier 1)', 359, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (622, 3, N'Preferred Pharmacy: Non-Preferred Generic (Tier 2)', 360, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (623, 3, N'Preferred Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', 361, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (624, 3, N'Preferred Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', 362, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (625, 3, N'Preferred Pharmacy: Specialty Drugs (Tier 5)', 363, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (626, 3, N'Vision: Eyewear Frames for Adults (Tier 1)', 386, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (627, 3, N'Vision: Eyewear Lenses for Adults', 387, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (628, 3, N'Vision: Contacts for Children', 388, N'300', N'N', N'Y', N'N', 1505)
INSERT [CS].[Screens] ([ScreenID], [TabPageID], [ScreenTitle], [ScreenOrder], [LeftColumnWidth], [IsHeader], [IsDynamicScreen], [IsMedicalServiceScreen], [ProductTypeId]) VALUES (629, 3, N'Vision: Eyewear Lenses for Children', 390, N'300', N'N', N'Y', N'N', 1505)


--UPDATES
UPDATE [CS].[TVLevel1] set [OrderNum] = 3 where [Level1ID] = 2

--INSERT
INSERT [CS].[TVLevel1] ([Level1ID], [Title], [OrderNum], [TabPageID], [IsHeader]) VALUES (19, N'CSP Products', 2, 2, N'N')
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (14, N'Medical Cost Share Details', N'N', 5, 9)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (546, N'Abortion', N'N', 313, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (547, N'Acupuncture', N'N', 314, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (548, N'Allergy Testing', N'N', 315, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (549, N'Ambulance Services', N'N', 316, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (550, N'Bariatric Surgery', N'N', 317, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (551, N'Chemotherapy', N'N', 318, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (552, N'Chiropractic Care', N'N', 319, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (553, N'Cosmetic Surgery', N'N', 320, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (554, N'Delivery and All Inpatient Services for Maternity Care', N'N', 321, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (555, N'Dental: Anesthesia', N'N', 322, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (556, N'Dental: Basic Dental Care for Children', N'N', 323, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (559, N'Dental: Basic Dental Services for Adults', N'N', 324, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (618, N'Dental: Major Dental Care for Children', N'N', 325, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (619, N'Dental: Major Dental Services for Adults', N'N', 326, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (558, N'Dental: Orthodontia for Children', N'N', 327, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (557, N'Dental: Preventive Dental Care for Children', N'N', 328, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (620, N'Dental: Preventive Dental Services for Adults', N'N', 329, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (560, N'Diabetes Services', N'N', 330, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (561, N'Dialysis', N'N', 331, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (562, N'Durable Medical Equipment', N'N', 332, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (563, N'Emergency Health Care Services - Outpatient', N'N', 333, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (564, N'Enteral Nutrition', N'N', 334, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (565, N'Foot Care', N'N', 335, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (566, N'Habilitative Services', N'N', 336, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (567, N'Hearing Aids', N'N', 337, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (568, N'Home Health Care', N'N', 338, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (569, N'Hospice Care', N'N', 339, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (570, N'Hospital - Inpatient Stay', N'N', 340, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (571, N'Infertility', N'N', 341, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (572, N'Infusion Therapy', N'N', 342, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (573, N'Inpatient Physician and Surgical Services', N'N', 343, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (574, N'Laboratory Outpatient and Professional Services - Office / Free - Standing Facility Based', N'N', 344, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (575, N'Laboratory Outpatient and Professional Services - Outpatient Hospital Based', N'N', 345, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (576, N'Long - Term / Custodial Nursing Home Care', N'N', 346, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (577, N'Major Diagnostic and Imaging - Office / Free - Standing Facility Based', N'N', 347, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (578, N'Major Diagnostic and Imaging - Outpatient Hospital Based', N'N', 348, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (579, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Inpatient', N'N', 349, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (580, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Office Visit', N'N', 350, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (581, N'Mental Health Care and Substance - Related and Addictive Disorders Services - Outpatient', N'N', 351, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (582, N'Nutritional Counseling', N'N', 352, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (583, N'Other Practitioner Office Visit(Nurse, Physician Assistant)', N'N', 353, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (584, N'Outpatient Facility Fee(e.g., Ambulatory Surgery Center) - Office / Free - Standing Facility Based', N'N', 354, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (585, N'Outpatient Facility Fee(e.g., Ambulatory Surgery Center) - Outpatient Hospital Based', N'N', 355, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (586, N'Outpatient Rehabilitation Services', N'N', 356, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (587, N'Outpatient Surgery Physician / Surgical Services - Office / Free - Standing Facility Based', N'N', 357, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (588, N'Outpatient Surgery Physician / Surgical Services - Outpatient Hospital Based', N'N', 358, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (621, N'Preferred Pharmacy: Preferred Generic (Tier 1)', N'N', 359, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (622, N'Preferred Pharmacy: Non-Preferred Generic (Tier 2)', N'N', 360, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (623, N'Preferred Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', N'N', 361, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (624, N'Preferred Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', N'N', 362, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (625, N'Preferred Pharmacy: Specialty Drugs (Tier 5)', N'N', 363, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (592, N'Pharmacy: Preferred Generic (Tier 1)', N'N', 364, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (589, N'Pharmacy: Non-Preferred Generic (Tier 2)', N'N', 365, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (591, N'Pharmacy: Non-Preferred Generic, Preferred Brand (Tier 3)', N'N', 366, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (590, N'Pharmacy: Non-Preferred Generic, Non-Preferred Brand (Tier 4)', N'N', 367, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (593, N'Pharmacy: Specialty Drugs (Tier 5)', N'N', 368, 15)
GO
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (594, N'Physician Office Services (PCP)', N'N', 369, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (595, N'Pregnancy - Maternity Services', N'N', 370, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (596, N'Prenatal and Postnatal Care', N'N', 371, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (597, N'Preventive Care Services', N'N', 372, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (598, N'Private Duty Nursing', N'N', 373, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (599, N'Prosthetic Devices', N'N', 374, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (600, N'Radiation', N'N', 375, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (601, N'Reconstructive Surgery', N'N', 376, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (602, N'Rehabilitative Occupational and Rehabilitative Physical Therapy', N'N', 377, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (603, N'Rehabilitative Speech Therapy', N'N', 378, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (604, N'Skilled Nursing Facility / Inpatient', N'N', 379, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (605, N'Specialist Visit', N'N', 380, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (607, N'Transplantation Services', N'N', 381, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (608, N'Temporomandibular Joint Syndrome(TMJ)', N'N', 382, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (609, N'Urgent Care Center Services', N'N', 383, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (610, N'Vendor Virtual Care Services', N'N', 384, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (606, N'Vision: Contacts for Adults', N'N', 385, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (626, N'Vision: Eyewear Frames for Adults (Tier 1)', N'N', 386, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (627, N'Vision: Eyewear Lenses for Adults', N'N', 387, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (628, N'Vision: Contacts for Children', N'N', 388, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (611, N'Vision: Eyewear Frames for Children (Tiers 1-5)', N'N', 389, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (629, N'Vision: Eyewear Lenses for Children', N'N', 390, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (612, N'Vision: Low Vision Therapy for Children', N'N', 391, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (614, N'Vision: Routine Eye Exam for Children', N'N', 392, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (613, N'Vision: Routine Eye Exams for Adults', N'N', 393, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (615, N'Weight Loss Programs', N'N', 394, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (616, N'X - rays and Diagnostic Imaging - Freestanding', N'N', 395, 15)
INSERT [CS].[TVLevel2] ([Level2ID], [Title], [IsHeader], [OrderNum], [Level1ID]) VALUES (617, N'X - rays and Diagnostic Imaging - Hospital Setting', N'N', 396, 15)
GO

end transaction