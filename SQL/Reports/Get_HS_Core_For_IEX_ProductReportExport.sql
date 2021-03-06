USE [BTB]
GO
/****** Object:  StoredProcedure [CS].[Get_HS_Core_For_ProductReportExport]    Script Date: 7/23/2021 4:27:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[CS].[Get_HS_Core_For_IEX_ProductReportExport] 40278, 40601
Alter proc [CS].[Get_HS_Core_For_IEX_ProductReportExport]
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

Lable2 varchar(max),

AuthInfoGoldStarApplicableID varchar(max),
AuthInfoGoldStarComments varchar(max),
AuthInfoGeneralComments varchar(max),  
Lable3 varchar(max),  
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
ServiceInfoCoveredID,ServiceInfoCoveredValidValueID,ServiceInfoCoveredByID,Lable2,AuthInfoGoldStarApplicableID,
AuthInfoGoldStarComments,AuthInfoGeneralComments,Lable3,AddBenInfoRules,AddBenInfoProviderRestrictions,AddBenInfoBenefitRestrictions,AddBenInfoAgeRestrictions,AddBenInfoGenderRestrictions,AddBenInfoProcessingRequirements,AddBenInfoPOSBillTypeImpl,AddBenInfoBenefitLimitComments,AddBenInfoGeneralLimitComments ,
AddBenInfoCCAMComments,AddBenInfoBCOComments ,AddBenInfoBCCSServiceIDs ,AddBenInfoBCCSServiceRule ,Label4 ,
BenSummInfoMemberGeneralInfo ,BenSummInfoProviderInfo ,Label5 ,MyUHCSummInfoMemberGeneralInfo)  
	SELECT def.ScreenID as ScreenID, (select ScreenOrder from CS.Screens s1 where s1.ScreenID =def.ScreenID) as ScreenOrder,(select Screentitle from CS.Screens s where s.ScreenID =def.ScreenID) as HealthService,

	'Service Information' as Label1,
	convert(varchar,convert(date,ServiceInfoBenEffDate,101),101) as ServiceInfoBenEffDate,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoBenefitCompletionStatusID) as ServiceInfoBenefitCompletionStatusID,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoCoveredID) as ServiceInfoCoveredID, ServiceInfoCoveredID as ServiceInfoCoveredValidValueID,
	(select ValidValueText from cs.validvalues where ValidValueID=ServiceInfoCoveredByID) as ServiceInfoCoveredByID,

	'Authorization Information' as Lable2,
	
	(select ValidValueText from cs.validvalues where ValidValueID=AuthInfoGoldStarApplicableID) as AuthInfoGoldStarApplicableID,
	AuthInfoGoldStarComments,
	AuthInfoGeneralComments,

	'Additional Benefit Information' as Lable3,
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
