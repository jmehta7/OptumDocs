-- use maps_Reporting
--use maps

-- SELECT
--	COLUMN_NAME
--FROM
--  	INFORMATION_SCHEMA.COLUMNS
--WHERE
--	TABLE_NAME = 'Temp_GroupBenSys_before'

---------------------------------------------------------------------------------------
	Select abc.BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance from Temp_HospitalCopay_IDCardElements_before as abc inner join Benefit b on b.BenefitID = abc.BenefitIDWhere b.EffectiveDate IN ('2019','2018','2020')EXCEPTSelect BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance from Temp_HospitalCopay_IDCardElements_afterSelect * from Temp_HospitalCopay_IDCardElements_after as abc inner join Benefit b on b.BenefitID = abc.BenefitIDWhere b.EffectiveDate NOT IN ('2019','2018','2020')----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------PRINT 'For Group Policies'Select abc.GroupID,abc.GroupNumber,GroupEffDate,MedicalPolicy,MedicalName,MedicalVendorName,MedicalEffDate,MedicalTermDate,MedicalFinancialProductCode,MedicalFinancialProduct2Code,MedicalRiskType,MedicalPanel,MedicalLegalEntity,RxPolicy,RxName,RxVendorName,RxEffDate,RxTermDate,RxFinancialProductCode,RxFinancialProduct2Code,RxRiskType,RxPanel,RxLegalEntity,DeluxePolicy,DeluxeName,DeluxeVendorName,DeluxeEffDate,DeluxeTermDate,DeluxeFinancialProductCode,DeluxeFinancialProduct2Code,DeluxeRiskType,DeluxePanel,DeluxeLegalEntity,DentalPolicy,DentalName,DentalVendorName,DentalEffDate,DentalTermDate,DentalFinancialProductCode,DentalFinancialProduct2Code,DentalRiskType,DentalPanel,DentalLegalEntity,VisionPolicy,VisionName,VisionVendorName,VisionEffDate,VisionTermDate,VisionFinancialProductCode,VisionFinancialProduct2Code,VisionRiskType,VisionPanel,VisionLegalEntity,MHSAPolicy,MHSAName,MHSAVendorName,MHSAEffDate,MHSATermDate,MHSAFinancialProductCode,MHSAFinancialProduct2Code,MHSARiskType,MHSAPanel,MHSALegalEntity,ATWPolicy,ATWName,ATWVendorName,ATWEffDate,ATWTermDate,ATWFinancialProductCode,ATWFinancialProduct2Code,ATWRiskType,ATWPanel,ATWLegalEntity,RespitePolicy,RespiteName,RespiteVendorName,RespiteEffDate,RespiteTermDate,RespiteFinancialProductCode,RespiteFinancialProduct2Code,RespiteRiskType,RespitePanel,RespiteLegalEntity,ChiroPolicy,ChiroName,ChiroVendorName,ChiroEffDate,ChiroTermDate,ChiroFinancialProductCode,ChiroFinancialProduct2Code,ChiroRiskType,ChiroPanel,ChiroLegalEntity,ACUPolicy,ACUName,ACUVendorName,ACUEffDate,ACUTermDate,ACUFinancialProductCode,ACUFinancialProduct2Code,ACURiskType,ACUPanel,ACULegalEntity,MassagePolicy,MassageName,MassageVendorName,MassageEffDate,MassageTermDate,MassageFinancialProductCode,MassageFinancialProduct2Code,MassageRiskType,MassagePanel,MassageLegalEntity,FitnessPolicy,FitnessName,FitnessVendorName,FitnessEffDate,FitnessTermDate,FitnessFinancialProductCode,FitnessFinancialProduct2Code,FitnessRiskType,FitnessPanel,FitnessLegalEntity,HearingPolicy,HearingName,HearingVendorName,HearingEffDate,HearingTermDate,HearingFinancialProductCode,HearingFinancialProduct2Code,HearingRiskType,HearingPanel,HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName,PHBEffDate,PHBTermDate,PHBFinancialProductCode,PHBFinancialProduct2Code,PHBRiskType,PHBPanel,PHBLegalEntity,NurselinePolicy,NurselineName,NurselineVendorName,NurselineEffDate,NurselineTermDate,NurselineFinancialProductCode,NurselineFinancialProduct2Code,NurselineRiskType,NurselinePanel,NurselineLegalEntity,CaregiverPolicy,CaregiverName,CaregiverVendorName,CaregiverEffDate,CaregiverTermDate,CaregiverFinancialProductCode,CaregiverFinancialProduct2Code,CaregiverRiskType,CaregiverPanel,CaregiverLegalEntity,WellnessPolicy,WellnessName,WellnessVendorName,WellnessEffDate,WellnessTermDate,WellnessFinancialProductCode,WellnessFinancialProduct2Code,WellnessRiskType,WellnessPanel,WellnessLegalEntity,NutritionPolicy,NutritionName,NutritionVendorName,NutritionEffDate,NutritionTermDate,NutritionFinancialProductCode,NutritionFinancialProduct2Code,NutritionRiskType,NutritionPanel,NutritionLegalEntity,PlusPolicy,PlusName,PlusVendorName,PlusEffDate,PlusTermDate,PlusFinancialProductCode,PlusFinancialProduct2Code,PlusRiskType,PlusPanel,PlusLegalEntity,Dental260Policy,Dental260Name,Dental260VendorName,Dental260EffDate,Dental260TermDate,Dental260FinancialProductCode,Dental260FinancialProduct2Code,Dental260RiskType,Dental260Panel,Dental260LegalEntity,Dental466Policy,Dental466Name,Dental466VendorName,Dental466EffDate,Dental466TermDate,Dental466FinancialProductCode,Dental466FinancialProduct2Code,Dental466RiskType,Dental466Panel,Dental466LegalEntity,Dental467Policy,Dental467Name,Dental467VendorName,Dental467EffDate,Dental467TermDate,Dental467FinancialProductCode,Dental467FinancialProduct2Code,Dental467RiskType,Dental467Panel,Dental467LegalEntity,Dental469Policy,Dental469Name,Dental469VendorName,Dental469EffDate,Dental469TermDate,Dental469FinancialProductCode,Dental469FinancialProduct2Code,Dental469RiskType,Dental469Panel,Dental469LegalEntity,DentalGoldPolicy,DentalGoldName,DentalGoldVendorName,DentalGoldEffDate,DentalGoldTermDate,DentalGoldFinancialProductCode,DentalGoldFinancialProduct2Code,DentalGoldRiskType,DentalGoldPanel,DentalGoldLegalEntity,DentalSilverPolicy,DentalSilverName,DentalSilverVendorName,DentalSilverEffDate,DentalSilverTermDate,DentalSilverFinancialProductCode,DentalSilverFinancialProduct2Code,DentalSilverRiskType,DentalSilverPanel,DentalSilverLegalEntity,HighOptionDentalPolicy,HighOptionDentalName,HighOptionDentalVendorName,HighOptionDentalEffDate,HighOptionDentalTermDate,HighOptionDentalFinancialProductCode,HighOptionDentalFinancialProduct2Code,HighOptionDentalRiskType,HighOptionDentalPanel,HighOptionDentalLegalEntity,OptionalDentalPolicy,OptionalDentalName,OptionalDentalVendorName,OptionalDentalEffDate,OptionalDentalTermDate,OptionalDentalFinancialProductCode,OptionalDentalFinancialProduct2Code,OptionalDentalRiskType,OptionalDentalPanel,OptionalDentalLegalEntity,DentalPlatinumPolicy,DentalPlatinumName,DentalPlatinumVendorName,DentalPlatinumEffDate,DentalPlatinumTermDate,DentalPlatinumFinancialProductCode,DentalPlatinumFinancialProduct2Code,DentalPlatinumRiskType,DentalPlatinumPanel,DentalPlatinumLegalEntity from Temp_GroupPolicies_b2 abc inner join [Group] gp ON gp.GroupID = abc.GroupID WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())     --Select *  --into Temp_GroupPolicies_b2 --from Temp_GroupPolicies_before EXCEPT Select  GroupID,GroupNumber,GroupEffDate,MedicalPolicy,MedicalName,MedicalVendorName,MedicalEffDate,MedicalTermDate,MedicalFinancialProductCode,MedicalFinancialProduct2Code,MedicalRiskType,MedicalPanel,MedicalLegalEntity,RxPolicy,RxName,RxVendorName,RxEffDate,RxTermDate,RxFinancialProductCode,RxFinancialProduct2Code,RxRiskType,RxPanel,RxLegalEntity,DeluxePolicy,DeluxeName,DeluxeVendorName,DeluxeEffDate,DeluxeTermDate,DeluxeFinancialProductCode,DeluxeFinancialProduct2Code,DeluxeRiskType,DeluxePanel,DeluxeLegalEntity,DentalPolicy,DentalName,DentalVendorName,DentalEffDate,DentalTermDate,DentalFinancialProductCode,DentalFinancialProduct2Code,DentalRiskType,DentalPanel,DentalLegalEntity,VisionPolicy,VisionName,VisionVendorName,VisionEffDate,VisionTermDate,VisionFinancialProductCode,VisionFinancialProduct2Code,VisionRiskType,VisionPanel,VisionLegalEntity,MHSAPolicy,MHSAName,MHSAVendorName,MHSAEffDate,MHSATermDate,MHSAFinancialProductCode,MHSAFinancialProduct2Code,MHSARiskType,MHSAPanel,MHSALegalEntity,ATWPolicy,ATWName,ATWVendorName,ATWEffDate,ATWTermDate,ATWFinancialProductCode,ATWFinancialProduct2Code,ATWRiskType,ATWPanel,ATWLegalEntity,RespitePolicy,RespiteName,RespiteVendorName,RespiteEffDate,RespiteTermDate,RespiteFinancialProductCode,RespiteFinancialProduct2Code,RespiteRiskType,RespitePanel,RespiteLegalEntity,ChiroPolicy,ChiroName,ChiroVendorName,ChiroEffDate,ChiroTermDate,ChiroFinancialProductCode,ChiroFinancialProduct2Code,ChiroRiskType,ChiroPanel,ChiroLegalEntity,ACUPolicy,ACUName,ACUVendorName,ACUEffDate,ACUTermDate,ACUFinancialProductCode,ACUFinancialProduct2Code,ACURiskType,ACUPanel,ACULegalEntity,MassagePolicy,MassageName,MassageVendorName,MassageEffDate,MassageTermDate,MassageFinancialProductCode,MassageFinancialProduct2Code,MassageRiskType,MassagePanel,MassageLegalEntity,FitnessPolicy,FitnessName,FitnessVendorName,FitnessEffDate,FitnessTermDate,FitnessFinancialProductCode,FitnessFinancialProduct2Code,FitnessRiskType,FitnessPanel,FitnessLegalEntity,HearingPolicy,HearingName,HearingVendorName,HearingEffDate,HearingTermDate,HearingFinancialProductCode,HearingFinancialProduct2Code,HearingRiskType,HearingPanel,HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName,PHBEffDate,PHBTermDate,PHBFinancialProductCode,PHBFinancialProduct2Code,PHBRiskType,PHBPanel,PHBLegalEntity,NurselinePolicy,NurselineName,NurselineVendorName,NurselineEffDate,NurselineTermDate,NurselineFinancialProductCode,NurselineFinancialProduct2Code,NurselineRiskType,NurselinePanel,NurselineLegalEntity,CaregiverPolicy,CaregiverName,CaregiverVendorName,CaregiverEffDate,CaregiverTermDate,CaregiverFinancialProductCode,CaregiverFinancialProduct2Code,CaregiverRiskType,CaregiverPanel,CaregiverLegalEntity,WellnessPolicy,WellnessName,WellnessVendorName,WellnessEffDate,WellnessTermDate,WellnessFinancialProductCode,WellnessFinancialProduct2Code,WellnessRiskType,WellnessPanel,WellnessLegalEntity,NutritionPolicy,NutritionName,NutritionVendorName,NutritionEffDate,NutritionTermDate,NutritionFinancialProductCode,NutritionFinancialProduct2Code,NutritionRiskType,NutritionPanel,NutritionLegalEntity,PlusPolicy,PlusName,PlusVendorName,PlusEffDate,PlusTermDate,PlusFinancialProductCode,PlusFinancialProduct2Code,PlusRiskType,PlusPanel,PlusLegalEntity,Dental260Policy,Dental260Name,Dental260VendorName,Dental260EffDate,Dental260TermDate,Dental260FinancialProductCode,Dental260FinancialProduct2Code,Dental260RiskType,Dental260Panel,Dental260LegalEntity,Dental466Policy,Dental466Name,Dental466VendorName,Dental466EffDate,Dental466TermDate,Dental466FinancialProductCode,Dental466FinancialProduct2Code,Dental466RiskType,Dental466Panel,Dental466LegalEntity,Dental467Policy,Dental467Name,Dental467VendorName,Dental467EffDate,Dental467TermDate,Dental467FinancialProductCode,Dental467FinancialProduct2Code,Dental467RiskType,Dental467Panel,Dental467LegalEntity,Dental469Policy,Dental469Name,Dental469VendorName,Dental469EffDate,Dental469TermDate,Dental469FinancialProductCode,Dental469FinancialProduct2Code,Dental469RiskType,Dental469Panel,Dental469LegalEntity,DentalGoldPolicy,DentalGoldName,DentalGoldVendorName,DentalGoldEffDate,DentalGoldTermDate,DentalGoldFinancialProductCode,DentalGoldFinancialProduct2Code,DentalGoldRiskType,DentalGoldPanel,DentalGoldLegalEntity,DentalSilverPolicy,DentalSilverName,DentalSilverVendorName,DentalSilverEffDate,DentalSilverTermDate,DentalSilverFinancialProductCode,DentalSilverFinancialProduct2Code,DentalSilverRiskType,DentalSilverPanel,DentalSilverLegalEntity,HighOptionDentalPolicy,HighOptionDentalName,HighOptionDentalVendorName,HighOptionDentalEffDate,HighOptionDentalTermDate,HighOptionDentalFinancialProductCode,HighOptionDentalFinancialProduct2Code,HighOptionDentalRiskType,HighOptionDentalPanel,HighOptionDentalLegalEntity,OptionalDentalPolicy,OptionalDentalName,OptionalDentalVendorName,OptionalDentalEffDate,OptionalDentalTermDate,OptionalDentalFinancialProductCode,OptionalDentalFinancialProduct2Code,OptionalDentalRiskType,OptionalDentalPanel,OptionalDentalLegalEntity,DentalPlatinumPolicy,DentalPlatinumName,DentalPlatinumVendorName,DentalPlatinumEffDate,DentalPlatinumTermDate,DentalPlatinumFinancialProductCode,DentalPlatinumFinancialProduct2Code,DentalPlatinumRiskType,DentalPlatinumPanel,DentalPlatinumLegalEntityfrom Temp_GroupPolicies_afterSelect * from  Temp_GroupPolicies_after g where  YEAR(g.GroupEffDate) NOT IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())   --where GroupEffDate NOT IN ('2020','2019','2018')Where GroupID  IN (Select abc.GroupID from Temp_GroupPolicies_after abc INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = abc.GroupId     
 --WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 WHERE YEAR(GP.EffectiveDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())   )  

 Select HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName from Temp_GroupPolicies_before g Where  --and g.GroupID = 26    
 YEAR(g.GroupEffDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())
 EXCEPT 
  Select HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName 
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
PlanID,abc.GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerNamefrom Temp_GroupBenefit_before abc inner join [Group] gp on gp.GroupID = abc.GroupIDwhere Year(gp.EffectiveDate) IN ('2019','2018','2020')EXCEPTSelect 
PlanID,GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerNamefrom Temp_GroupBenefit_after--------------------------------------------------------------------------------------------------------------PRINT 'For Temp_HospitalCopay'
  SELECT [IGPlan].GroupID,[IGPlan].PlanID,ipb.BenefitId 
  into #Temp_HospitalCopaytab
  FROM [IndividualGroupPlan] [IGPlan] WITH(NOLOCK)         
  LEFT JOIN IndividualPlanBenefit ipb WITH(NOLOCK) ON  [IGPlan].PlanId = ipb.PlanID        
  UNION        
  SELECT  GroupID,PlanID,BenefitId FROM [EmployerGroupPlanBenefit] [EGPlan] WITH(NOLOCK)        
 Select BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurancefrom Temp_HospitalCopay_before where BenefitID IN ( 
SELECT BenefitId FROM #Temp_HospitalCopaytab abc  
inner join [Group] gp ON abc.GroupID = gp.GroupID where YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()))

  EXCEPT

  Select 
  BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance
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
		 BenefitID		,InpatientHospitalCopay		,PhysicianCopay		,SpecialistCopay		,EmergencyCopay		,PhysicianCoinsurance		,SpecialistCoinsurance		,EmergencyCoinsurance
		from [Temp_HospitalCopay_IDCardElements_before] where BenefitID IN ( 
SELECT BenefitId FROM #HospitalCopayIDCardElement abc  
inner join [Group] gp ON abc.GroupID = gp.GroupID where YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()))
EXCEPT 
Select 
BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance
from [Temp_HospitalCopay_IDCardElements_after]
DROP TABLE #HospitalCopayIDCardElement
---------------------------------------------------------------------------

PRINT 'For Temp_GroupBenefit'
Select abc.GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerName
from Temp_GroupBenefit_before abc inner join [Group] gp on gp.GroupID = abc.GroupID
Where YEAR(gp.EffectiveDate) IN (SELECT [Years] FROM dbo.udfGetPrevCurrNextYears())
EXCEPT 

Select GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerName
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

abc.GroupID,abc.PlanID,abc.GroupNumber,GroupEffDate,MedicalBenSys,MedicalEffDate,MedicalTermDate,RxBenSys,RxEffDate,RxTermDate,DeluxeBenSys,DeluxeEffDate,DeluxeTermDate,DentalBenSys,DentalEffDate,DentalTermDate,VisionBenSys,VisionEffDate,VisionTermDate,MHSABenSys,MHSAEffDate,MHSATermDate,ATWBenSys,ATWEffDate,ATWTermDate,RespiteBenSys,RespiteEffDate,RespiteTermDate,ChiroBenSys,ChiroEffDate,ChiroTermDate,ACUBenSys,ACUEffDate,ACUTermDate,MassageBenSys,MassageEffDate,MassageTermDate,FitnessBenSys,FitnessEffDate,FitnessTermDate,HearingBenSys,HearingEffDate,HearingTermDate,PodiatryBenSys,PodiatryEffDate,PodiatryTermDate,NonEmergencyBenSys,NonEmergencyEffDate,NonEmergencyTermDate,PHBBenSys,PHBEffDate,PHBTermDate,NurseLineBenSys,NurseLineEffDate,NurseLineTermDate,CareGiverBenSys,CareGiverEffDate,CareGiverTermDate,WellnessBenSys,WellnessEffDate,WellnessTermDate,NutritionBenSys,NutritionEffDate,NutritionTermDate,PlusBenSys,PlusEffDate,PlusTermDate,Dental260BenSys,Dental260EffDate,Dental260TermDate,Dental466BenSys,Dental466EffDate,Dental466TermDate,Dental467BenSys,Dental467EffDate,Dental467TermDate,Dental469BenSys,Dental469EffDate,Dental469TermDate,DentalGoldBenSys,DentalGoldEffDate,DentalGoldTermDate,DentalSilverBenSys,DentalSilverEffDate,DentalSilverTermDate,HighOptionDentalBenSys,HighOptionDentalEffDate,HighOptionDentalTermDate,OptionalDentalBenSys,OptionalDentalEffDate,OptionalDentalTermDate,DentalPlatinumBenSys,DentalPlatinumEffDate,DentalPlatinumTermDatefrom [Temp_GroupBenSys_before] abc
INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = abc.GroupId           
       WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')           
       AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())


	   EXCEPT 

	   Select 
	   GroupID,PlanID,GroupNumber,GroupEffDate,MedicalBenSys,MedicalEffDate,MedicalTermDate,RxBenSys,RxEffDate,RxTermDate,DeluxeBenSys,DeluxeEffDate,DeluxeTermDate,DentalBenSys,DentalEffDate,DentalTermDate,VisionBenSys,VisionEffDate,VisionTermDate,MHSABenSys,MHSAEffDate,MHSATermDate,ATWBenSys,ATWEffDate,ATWTermDate,RespiteBenSys,RespiteEffDate,RespiteTermDate,ChiroBenSys,ChiroEffDate,ChiroTermDate,ACUBenSys,ACUEffDate,ACUTermDate,MassageBenSys,MassageEffDate,MassageTermDate,FitnessBenSys,FitnessEffDate,FitnessTermDate,HearingBenSys,HearingEffDate,HearingTermDate,PodiatryBenSys,PodiatryEffDate,PodiatryTermDate,NonEmergencyBenSys,NonEmergencyEffDate,NonEmergencyTermDate,PHBBenSys,PHBEffDate,PHBTermDate,NurseLineBenSys,NurseLineEffDate,NurseLineTermDate,CareGiverBenSys,CareGiverEffDate,CareGiverTermDate,WellnessBenSys,WellnessEffDate,WellnessTermDate,NutritionBenSys,NutritionEffDate,NutritionTermDate,PlusBenSys,PlusEffDate,PlusTermDate,Dental260BenSys,Dental260EffDate,Dental260TermDate,Dental466BenSys,Dental466EffDate,Dental466TermDate,Dental467BenSys,Dental467EffDate,Dental467TermDate,Dental469BenSys,Dental469EffDate,Dental469TermDate,DentalGoldBenSys,DentalGoldEffDate,DentalGoldTermDate,DentalSilverBenSys,DentalSilverEffDate,DentalSilverTermDate,HighOptionDentalBenSys,HighOptionDentalEffDate,HighOptionDentalTermDate,OptionalDentalBenSys,OptionalDentalEffDate,OptionalDentalTermDate,DentalPlatinumBenSys,DentalPlatinumEffDate,DentalPlatinumTermDatefrom Temp_GroupBenSys_before------------------------------------------------------------------To check Duplicate Records in tables
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
   GROUP BY PlanID,GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerName
HAVING COUNT(*) > 1








SELECT PlanID,
CMSStateCode,
State,
CountyNameList,
CountyList , CreateDate, COUNT(*) as cnt
FROM [Temp_GroupCountiesRPT](nolock) 
where Year(CreateDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]() )
 GROUP BYPlanID,
CMSStateCode,
State,r
CountyNameList,
CountyList
HAVING COUNT(*) > 1 order by CreateDate desc

Select top 1000 * from [Temp_GroupCountiesRPT](nolock) where Year(CreateDate) NOT IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]() ) order by 1 desc
-----------------------------------------------------------------------------------------------------------------------------------------------------------