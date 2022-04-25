use maps

Select top 10 * from BatchExtractLog(nolock) order by 1 desc

--2019-06-14 09:54:46.780	2019-06-14 10:01:42.350
--2019-06-14 09:32:42.960	2019-06-14 09:42:07.260

--DROP TABLE Temp_HospitalCopay_IDCardElements_before
--DROP TABLE Temp_HospitalCopay_before
--DROP TABLE Temp_GroupPolicies_before
--DROP TABLE Temp_GroupBenSys_before
--DROP TABLE Temp_GroupBenefit_before
--DROP TABLE Temp_GroupChangeCodes_before



--DROP TABLE Temp_HospitalCopay_IDCardElements_after
--DROP TABLE Temp_HospitalCopay_after
--DROP TABLE Temp_GroupPolicies_after
--DROP TABLE Temp_GroupBenSys_after
--DROP TABLE Temp_GroupBenefit_after
--DROP TABLE Temp_GroupChangeCodes_after

sp_helptext RPT_iHospitalCopay_IDCardElements
sp_helptext RPT_iHospitalCopay
sp_helptext RPT_iGroupPolicies
sp_helptext RPT_iGroupChangeCodes
sp_helptext RPT_iGroupBenSys
sp_helptext RPT_iGroupBenefits


Select * into Temp_HospitalCopay_IDCardElements_before
 from Temp_HospitalCopay_IDCardElements

 Select * into Temp_HospitalCopay_before
 from Temp_HospitalCopay

 Select * into Temp_GroupPolicies_before
 from Temp_GroupPolicies

 Select * into Temp_GroupBenSys_before
 from Temp_GroupBenSys


 Select * into Temp_GroupBenefit_before
 from Temp_GroupBenefit
 
 Select * into Temp_GroupChangeCodes_before
 from Temp_GroupChangeCodes



--Temp_HospitalCopay_IDCardElements_before       --diff 4698
--Temp_HospitalCopay_before       --diff 4660
--Temp_GroupPolicies_before  -- diff 7182
--Already Optimized
--Temp_GroupChangeCodes_before  --
--Temp_GroupBenSys_before  --diff 7178
--Temp_GroupBenefit_before --diff 7182
--Dev2  Results -- Diff Temp_HospitalCopay_IDCardElements 4799

 Select  CreateDate,* from  Temp_HospitalCopay_IDCardElements order by 1 desc
 Select  CreateDate,* from  Temp_HospitalCopay order by 1 desc
 Select  top 10000 CreateDate,* from  Temp_GroupPolicies_after order by 1 desc
 Select top 7179 CreateDate,* from  Temp_GroupBenSys order by 1 desc
   Select  top 7183 CreateDate,* from  Temp_GroupBenefit order by 1 desc
 Select  CreateDate,* from  Temp_GroupChangeCodes order by 1 desc
-------------------------------------------------------------------------------------------------
Select * into Temp_HospitalCopay_IDCardElements_after
 from Temp_HospitalCopay_IDCardElements

 Select * into Temp_HospitalCopay_after
 from Temp_HospitalCopay

 Select * into Temp_GroupPolicies_after
 from Temp_GroupPolicies

 Select * into Temp_GroupBenSys_after
 from Temp_GroupBenSys


 Select * into Temp_GroupBenefit_after
 from Temp_GroupBenefit
 
 Select * into Temp_GroupChangeCodes_after
 from Temp_GroupChangeCodes
 ----------------------------------------------------------------------------------------
 

 
Select Count(*) from Temp_HospitalCopay_IDCardElements
 Select Count(*) from Temp_HospitalCopay_IDCardElements_before


 
Select  BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance,CreateBy,CreateDate--,Temp_HospitalCopayID_IDCardElements 
from Temp_HospitalCopay_IDCardElements order by 1 desc
EXCEPT
 Select BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance,CreateBy--,CreateDate--,Temp_HospitalCopayID_IDCardElements 
from Temp_HospitalCopay_IDCardElements_before

 -----------------------------------------------------------------------------------------------------------
 
Select Count(*) from Temp_HospitalCopay
 Select Count(*) from Temp_HospitalCopay_before

 
Select BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance,CreateBy,CreateDate--,Temp_HospitalCopayID
 from Temp_HospitalCopay order by 1 desc
 EXCEPT
 Select BenefitID,InpatientHospitalCopay,PhysicianCopay,SpecialistCopay,EmergencyCopay,PhysicianCoinsurance,SpecialistCoinsurance,EmergencyCoinsurance,CreateBy--,CreateDate--,Temp_HospitalCopayID
 from Temp_HospitalCopay_before


 
 -----------------------------------------------------------------------------------------------
 
 Select Count(*) from Temp_GroupPolicies
 Select Count(*) from Temp_GroupPolicies_before
 

 Select 
 GroupID,GroupNumber,GroupEffDate,MedicalPolicy,MedicalName,MedicalVendorName,MedicalEffDate,MedicalTermDate,MedicalFinancialProductCode,MedicalFinancialProduct2Code,MedicalRiskType,MedicalPanel,MedicalLegalEntity,RxPolicy,RxName,RxVendorName,RxEffDate,RxTermDate,RxFinancialProductCode,RxFinancialProduct2Code,RxRiskType,RxPanel,RxLegalEntity,DeluxePolicy,DeluxeName,DeluxeVendorName,DeluxeEffDate,DeluxeTermDate,DeluxeFinancialProductCode,DeluxeFinancialProduct2Code,DeluxeRiskType,DeluxePanel,DeluxeLegalEntity,DentalPolicy,DentalName,DentalVendorName,DentalEffDate,DentalTermDate,DentalFinancialProductCode,DentalFinancialProduct2Code,DentalRiskType,DentalPanel,DentalLegalEntity,VisionPolicy,VisionName,VisionVendorName,VisionEffDate,VisionTermDate,VisionFinancialProductCode,VisionFinancialProduct2Code,VisionRiskType,VisionPanel,VisionLegalEntity,MHSAPolicy,MHSAName,MHSAVendorName,MHSAEffDate,MHSATermDate,MHSAFinancialProductCode,MHSAFinancialProduct2Code,MHSARiskType,MHSAPanel,MHSALegalEntity,ATWPolicy,ATWName,ATWVendorName,ATWEffDate,ATWTermDate,ATWFinancialProductCode,ATWFinancialProduct2Code,ATWRiskType,ATWPanel,ATWLegalEntity,RespitePolicy,RespiteName,RespiteVendorName,RespiteEffDate,RespiteTermDate,RespiteFinancialProductCode,RespiteFinancialProduct2Code,RespiteRiskType,RespitePanel,RespiteLegalEntity,ChiroPolicy,ChiroName,ChiroVendorName,ChiroEffDate,ChiroTermDate,ChiroFinancialProductCode,ChiroFinancialProduct2Code,ChiroRiskType,ChiroPanel,ChiroLegalEntity,ACUPolicy,ACUName,ACUVendorName,ACUEffDate,ACUTermDate,ACUFinancialProductCode,ACUFinancialProduct2Code,ACURiskType,ACUPanel,ACULegalEntity,MassagePolicy,MassageName,MassageVendorName,MassageEffDate,MassageTermDate,MassageFinancialProductCode,MassageFinancialProduct2Code,MassageRiskType,MassagePanel,MassageLegalEntity,FitnessPolicy,FitnessName,FitnessVendorName,FitnessEffDate,FitnessTermDate,FitnessFinancialProductCode,FitnessFinancialProduct2Code,FitnessRiskType,FitnessPanel,FitnessLegalEntity,HearingPolicy,HearingName,HearingVendorName,HearingEffDate,HearingTermDate,HearingFinancialProductCode,HearingFinancialProduct2Code,HearingRiskType,HearingPanel,HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName,PHBEffDate,PHBTermDate,PHBFinancialProductCode,PHBFinancialProduct2Code,PHBRiskType,PHBPanel,PHBLegalEntity,NurselinePolicy,NurselineName,NurselineVendorName,NurselineEffDate,NurselineTermDate,NurselineFinancialProductCode,NurselineFinancialProduct2Code,NurselineRiskType,NurselinePanel,NurselineLegalEntity,CaregiverPolicy,CaregiverName,CaregiverVendorName,CaregiverEffDate,CaregiverTermDate,CaregiverFinancialProductCode,CaregiverFinancialProduct2Code,CaregiverRiskType,CaregiverPanel,CaregiverLegalEntity,WellnessPolicy,WellnessName,WellnessVendorName,WellnessEffDate,WellnessTermDate,WellnessFinancialProductCode,WellnessFinancialProduct2Code,WellnessRiskType,WellnessPanel,WellnessLegalEntity,NutritionPolicy,NutritionName,NutritionVendorName,NutritionEffDate,NutritionTermDate,NutritionFinancialProductCode,NutritionFinancialProduct2Code,NutritionRiskType,NutritionPanel,NutritionLegalEntity,PlusPolicy,PlusName,PlusVendorName,PlusEffDate,PlusTermDate,PlusFinancialProductCode,PlusFinancialProduct2Code,PlusRiskType,PlusPanel,PlusLegalEntity,Dental260Policy,Dental260Name,Dental260VendorName,Dental260EffDate,Dental260TermDate,Dental260FinancialProductCode,Dental260FinancialProduct2Code,Dental260RiskType,Dental260Panel,Dental260LegalEntity,Dental466Policy,Dental466Name,Dental466VendorName,Dental466EffDate,Dental466TermDate,Dental466FinancialProductCode,Dental466FinancialProduct2Code,Dental466RiskType,Dental466Panel,Dental466LegalEntity,Dental467Policy,Dental467Name,Dental467VendorName,Dental467EffDate,Dental467TermDate,Dental467FinancialProductCode,Dental467FinancialProduct2Code,Dental467RiskType,Dental467Panel,Dental467LegalEntity,Dental469Policy,Dental469Name,Dental469VendorName,Dental469EffDate,Dental469TermDate,Dental469FinancialProductCode,Dental469FinancialProduct2Code,Dental469RiskType,Dental469Panel,Dental469LegalEntity,DentalGoldPolicy,DentalGoldName,DentalGoldVendorName,DentalGoldEffDate,DentalGoldTermDate,DentalGoldFinancialProductCode,DentalGoldFinancialProduct2Code,DentalGoldRiskType,DentalGoldPanel,DentalGoldLegalEntity,DentalSilverPolicy,DentalSilverName,DentalSilverVendorName,DentalSilverEffDate,DentalSilverTermDate,DentalSilverFinancialProductCode,DentalSilverFinancialProduct2Code,DentalSilverRiskType,DentalSilverPanel,DentalSilverLegalEntity,HighOptionDentalPolicy,HighOptionDentalName,HighOptionDentalVendorName,HighOptionDentalEffDate,HighOptionDentalTermDate,HighOptionDentalFinancialProductCode,HighOptionDentalFinancialProduct2Code,HighOptionDentalRiskType,HighOptionDentalPanel,HighOptionDentalLegalEntity,OptionalDentalPolicy,OptionalDentalName,OptionalDentalVendorName,OptionalDentalEffDate,OptionalDentalTermDate,OptionalDentalFinancialProductCode,OptionalDentalFinancialProduct2Code,OptionalDentalRiskType,OptionalDentalPanel,OptionalDentalLegalEntity,DentalPlatinumPolicy,DentalPlatinumName,DentalPlatinumVendorName,DentalPlatinumEffDate,DentalPlatinumTermDate,DentalPlatinumFinancialProductCode,DentalPlatinumFinancialProduct2Code,DentalPlatinumRiskType,DentalPlatinumPanel,DentalPlatinumLegalEntity,CreateBy--,CreateDate--,Temp_GroupPoliciesID
from Temp_GroupPolicies

EXCEPT 

Select 
GroupID,GroupNumber,GroupEffDate,MedicalPolicy,MedicalName,MedicalVendorName,MedicalEffDate,MedicalTermDate,MedicalFinancialProductCode,MedicalFinancialProduct2Code,MedicalRiskType,MedicalPanel,MedicalLegalEntity,RxPolicy,RxName,RxVendorName,RxEffDate,RxTermDate,RxFinancialProductCode,RxFinancialProduct2Code,RxRiskType,RxPanel,RxLegalEntity,DeluxePolicy,DeluxeName,DeluxeVendorName,DeluxeEffDate,DeluxeTermDate,DeluxeFinancialProductCode,DeluxeFinancialProduct2Code,DeluxeRiskType,DeluxePanel,DeluxeLegalEntity,DentalPolicy,DentalName,DentalVendorName,DentalEffDate,DentalTermDate,DentalFinancialProductCode,DentalFinancialProduct2Code,DentalRiskType,DentalPanel,DentalLegalEntity,VisionPolicy,VisionName,VisionVendorName,VisionEffDate,VisionTermDate,VisionFinancialProductCode,VisionFinancialProduct2Code,VisionRiskType,VisionPanel,VisionLegalEntity,MHSAPolicy,MHSAName,MHSAVendorName,MHSAEffDate,MHSATermDate,MHSAFinancialProductCode,MHSAFinancialProduct2Code,MHSARiskType,MHSAPanel,MHSALegalEntity,ATWPolicy,ATWName,ATWVendorName,ATWEffDate,ATWTermDate,ATWFinancialProductCode,ATWFinancialProduct2Code,ATWRiskType,ATWPanel,ATWLegalEntity,RespitePolicy,RespiteName,RespiteVendorName,RespiteEffDate,RespiteTermDate,RespiteFinancialProductCode,RespiteFinancialProduct2Code,RespiteRiskType,RespitePanel,RespiteLegalEntity,ChiroPolicy,ChiroName,ChiroVendorName,ChiroEffDate,ChiroTermDate,ChiroFinancialProductCode,ChiroFinancialProduct2Code,ChiroRiskType,ChiroPanel,ChiroLegalEntity,ACUPolicy,ACUName,ACUVendorName,ACUEffDate,ACUTermDate,ACUFinancialProductCode,ACUFinancialProduct2Code,ACURiskType,ACUPanel,ACULegalEntity,MassagePolicy,MassageName,MassageVendorName,MassageEffDate,MassageTermDate,MassageFinancialProductCode,MassageFinancialProduct2Code,MassageRiskType,MassagePanel,MassageLegalEntity,FitnessPolicy,FitnessName,FitnessVendorName,FitnessEffDate,FitnessTermDate,FitnessFinancialProductCode,FitnessFinancialProduct2Code,FitnessRiskType,FitnessPanel,FitnessLegalEntity,HearingPolicy,HearingName,HearingVendorName,HearingEffDate,HearingTermDate,HearingFinancialProductCode,HearingFinancialProduct2Code,HearingRiskType,HearingPanel,HearingLegalEntity,PodiatryPolicy,PodiatryName,PodiatryVendorName,PodiatryEffDate,PodiatryTermDate,PodiatryFinancialProductCode,PodiatryFinancialProduct2Code,PodiatryRiskType,PodiatryPanel,PodiatryLegalEntity,NonEmergencyPolicy,NonEmergencyName,NonEmergencyVendorName,NonEmergencyEffDate,NonEmergencyTermDate,NonEmergencyFinancialProductCode,NonEmergencyFinancialProduct2Code,NonEmergencyRiskType,NonEmergencyPanel,NonEmergencyLegalEntity,PHBPolicy,PHBName,PHBVendorName,PHBEffDate,PHBTermDate,PHBFinancialProductCode,PHBFinancialProduct2Code,PHBRiskType,PHBPanel,PHBLegalEntity,NurselinePolicy,NurselineName,NurselineVendorName,NurselineEffDate,NurselineTermDate,NurselineFinancialProductCode,NurselineFinancialProduct2Code,NurselineRiskType,NurselinePanel,NurselineLegalEntity,CaregiverPolicy,CaregiverName,CaregiverVendorName,CaregiverEffDate,CaregiverTermDate,CaregiverFinancialProductCode,CaregiverFinancialProduct2Code,CaregiverRiskType,CaregiverPanel,CaregiverLegalEntity,WellnessPolicy,WellnessName,WellnessVendorName,WellnessEffDate,WellnessTermDate,WellnessFinancialProductCode,WellnessFinancialProduct2Code,WellnessRiskType,WellnessPanel,WellnessLegalEntity,NutritionPolicy,NutritionName,NutritionVendorName,NutritionEffDate,NutritionTermDate,NutritionFinancialProductCode,NutritionFinancialProduct2Code,NutritionRiskType,NutritionPanel,NutritionLegalEntity,PlusPolicy,PlusName,PlusVendorName,PlusEffDate,PlusTermDate,PlusFinancialProductCode,PlusFinancialProduct2Code,PlusRiskType,PlusPanel,PlusLegalEntity,Dental260Policy,Dental260Name,Dental260VendorName,Dental260EffDate,Dental260TermDate,Dental260FinancialProductCode,Dental260FinancialProduct2Code,Dental260RiskType,Dental260Panel,Dental260LegalEntity,Dental466Policy,Dental466Name,Dental466VendorName,Dental466EffDate,Dental466TermDate,Dental466FinancialProductCode,Dental466FinancialProduct2Code,Dental466RiskType,Dental466Panel,Dental466LegalEntity,Dental467Policy,Dental467Name,Dental467VendorName,Dental467EffDate,Dental467TermDate,Dental467FinancialProductCode,Dental467FinancialProduct2Code,Dental467RiskType,Dental467Panel,Dental467LegalEntity,Dental469Policy,Dental469Name,Dental469VendorName,Dental469EffDate,Dental469TermDate,Dental469FinancialProductCode,Dental469FinancialProduct2Code,Dental469RiskType,Dental469Panel,Dental469LegalEntity,DentalGoldPolicy,DentalGoldName,DentalGoldVendorName,DentalGoldEffDate,DentalGoldTermDate,DentalGoldFinancialProductCode,DentalGoldFinancialProduct2Code,DentalGoldRiskType,DentalGoldPanel,DentalGoldLegalEntity,DentalSilverPolicy,DentalSilverName,DentalSilverVendorName,DentalSilverEffDate,DentalSilverTermDate,DentalSilverFinancialProductCode,DentalSilverFinancialProduct2Code,DentalSilverRiskType,DentalSilverPanel,DentalSilverLegalEntity,HighOptionDentalPolicy,HighOptionDentalName,HighOptionDentalVendorName,HighOptionDentalEffDate,HighOptionDentalTermDate,HighOptionDentalFinancialProductCode,HighOptionDentalFinancialProduct2Code,HighOptionDentalRiskType,HighOptionDentalPanel,HighOptionDentalLegalEntity,OptionalDentalPolicy,OptionalDentalName,OptionalDentalVendorName,OptionalDentalEffDate,OptionalDentalTermDate,OptionalDentalFinancialProductCode,OptionalDentalFinancialProduct2Code,OptionalDentalRiskType,OptionalDentalPanel,OptionalDentalLegalEntity,DentalPlatinumPolicy,DentalPlatinumName,DentalPlatinumVendorName,DentalPlatinumEffDate,DentalPlatinumTermDate,DentalPlatinumFinancialProductCode,DentalPlatinumFinancialProduct2Code,DentalPlatinumRiskType,DentalPlatinumPanel,DentalPlatinumLegalEntity,CreateBy--,CreateDate--,Temp_GroupPoliciesID
from 
Temp_GroupPolicies_before

----------------------------------------------------------------------------------------

 Select Count(*) from Temp_GroupBenSys
 Select Count(*) from Temp_GroupBenSys_before

 Select 
GroupID,PlanID,GroupNumber,GroupEffDate,MedicalBenSys,MedicalEffDate,MedicalTermDate,RxBenSys,RxEffDate,RxTermDate,DeluxeBenSys,DeluxeEffDate,DeluxeTermDate,DentalBenSys,DentalEffDate,DentalTermDate,VisionBenSys,VisionEffDate,VisionTermDate,MHSABenSys,MHSAEffDate,MHSATermDate,ATWBenSys,ATWEffDate,ATWTermDate,RespiteBenSys,RespiteEffDate,RespiteTermDate,ChiroBenSys,ChiroEffDate,ChiroTermDate,ACUBenSys,ACUEffDate,ACUTermDate,MassageBenSys,MassageEffDate,MassageTermDate,FitnessBenSys,FitnessEffDate,FitnessTermDate,HearingBenSys,HearingEffDate,HearingTermDate,PodiatryBenSys,PodiatryEffDate,PodiatryTermDate,NonEmergencyBenSys,NonEmergencyEffDate,NonEmergencyTermDate,PHBBenSys,PHBEffDate,PHBTermDate,NurseLineBenSys,NurseLineEffDate,NurseLineTermDate,CareGiverBenSys,CareGiverEffDate,CareGiverTermDate,WellnessBenSys,WellnessEffDate,WellnessTermDate,NutritionBenSys,NutritionEffDate,NutritionTermDate,PlusBenSys,PlusEffDate,PlusTermDate,Dental260BenSys,Dental260EffDate,Dental260TermDate,Dental466BenSys,Dental466EffDate,Dental466TermDate,Dental467BenSys,Dental467EffDate,Dental467TermDate,Dental469BenSys,Dental469EffDate,Dental469TermDate,DentalGoldBenSys,DentalGoldEffDate,DentalGoldTermDate,DentalSilverBenSys,DentalSilverEffDate,DentalSilverTermDate,HighOptionDentalBenSys,HighOptionDentalEffDate,HighOptionDentalTermDate,OptionalDentalBenSys,OptionalDentalEffDate,OptionalDentalTermDate,DentalPlatinumBenSys,DentalPlatinumEffDate,DentalPlatinumTermDate,CreateBy--,CreateDate--,Temp_GroupBenSysIDfrom Temp_GroupBenSys_before
	   EXCEPT
Select 
GroupID,PlanID,GroupNumber,GroupEffDate,MedicalBenSys,MedicalEffDate,MedicalTermDate,RxBenSys,RxEffDate,RxTermDate,DeluxeBenSys,DeluxeEffDate,DeluxeTermDate,DentalBenSys,DentalEffDate,DentalTermDate,VisionBenSys,VisionEffDate,VisionTermDate,MHSABenSys,MHSAEffDate,MHSATermDate,ATWBenSys,ATWEffDate,ATWTermDate,RespiteBenSys,RespiteEffDate,RespiteTermDate,ChiroBenSys,ChiroEffDate,ChiroTermDate,ACUBenSys,ACUEffDate,ACUTermDate,MassageBenSys,MassageEffDate,MassageTermDate,FitnessBenSys,FitnessEffDate,FitnessTermDate,HearingBenSys,HearingEffDate,HearingTermDate,PodiatryBenSys,PodiatryEffDate,PodiatryTermDate,NonEmergencyBenSys,NonEmergencyEffDate,NonEmergencyTermDate,PHBBenSys,PHBEffDate,PHBTermDate,NurseLineBenSys,NurseLineEffDate,NurseLineTermDate,CareGiverBenSys,CareGiverEffDate,CareGiverTermDate,WellnessBenSys,WellnessEffDate,WellnessTermDate,NutritionBenSys,NutritionEffDate,NutritionTermDate,PlusBenSys,PlusEffDate,PlusTermDate,Dental260BenSys,Dental260EffDate,Dental260TermDate,Dental466BenSys,Dental466EffDate,Dental466TermDate,Dental467BenSys,Dental467EffDate,Dental467TermDate,Dental469BenSys,Dental469EffDate,Dental469TermDate,DentalGoldBenSys,DentalGoldEffDate,DentalGoldTermDate,DentalSilverBenSys,DentalSilverEffDate,DentalSilverTermDate,HighOptionDentalBenSys,HighOptionDentalEffDate,HighOptionDentalTermDate,OptionalDentalBenSys,OptionalDentalEffDate,OptionalDentalTermDate,DentalPlatinumBenSys,DentalPlatinumEffDate,DentalPlatinumTermDate,CreateBy--,CreateDate--,Temp_GroupBenSysIDfrom Temp_GroupBenSys


---------------------------------------------------------------------------------------- 
 Select Count(*) from Temp_GroupBenefit
 Select Count(*) from Temp_GroupBenefit_before


 Select GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerName
,CreateBy
--,CreateDate
--,Temp_GroupBenefitID

from Temp_GroupBenefit_before
EXCEPT 

Select GroupID,PlanTypeID,MedicalPremium,DentalPremium,VisionPremium,RxPremium,MHSAPremium,DeluxePremium,ATWPremium,RespitePremium,ChiroPremium,ACUPremium,MassagePremium,FitnessPremium,HearingPremium,PodiatryPremium,NonEmergencyPremium,PHBPremium,NurselinePremium,CaregiverPremium,WellnessPremium,NutritionPremium,PlusPremium,Dental260Premium,Dental466Premium,Dental467Premium,Dental469Premium,DentalGoldPremium,DentalSilverPremium,HighOptionDentalPremium,OptionalDentalPremium,DentalPlatinumPremium,BrandName,DrugCoverageType,PlanLongName,IsPassportFlag,IsRDSFlag,IsCostShareIndicator,IsOpenAccess,IsGateKeeper,IsSpecialistSelfReferral,IDCardEmployerName
,CreateBy
--,CreateDate
--,Temp_GroupBenefitID
from Temp_GroupBenefit



 
 ----------------------------------------------------------------------------------------
 Select Count(*) from Temp_GroupChangeCodes
 Select Count(*) from Temp_GroupChangeCodes_before
 
 Select 
--GroupID
--GroupMoveFrom
GroupMoveFromList
,DivisionMoveFrom
,ChangeCode
,CreateBy
--,CreateDate
--,Temp_GroupChangeCodesID
from Temp_GroupChangeCodes_before 
  EXCEPT 
 Select 
--GroupID
--GroupMoveFrom
GroupMoveFromList
,DivisionMoveFrom
,ChangeCode
,CreateBy
--,CreateDate
--,Temp_GroupChangeCodesID
from Temp_GroupChangeCodes
-----------------------------------------------------------------------------------------