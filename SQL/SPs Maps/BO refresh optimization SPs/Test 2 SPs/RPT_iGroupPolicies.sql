-- Jatin 6/3/2019 : Changed DROP command to DELETE , dropped clustered index     
-- Jatin 07/03/2019 : and make it non cluster and added identity column and make it primary key     
-- and make it non cluster and addedidentity column and make it primary key  and added insert into statement  
  
ALTER Proc [dbo].[RPT_iGroupPolicies]    
As    
Select Distinct     
row_number() over (partition by g.GroupID,PolicyTypeID    
                   order by GroupNumber,g.EffectiveDate) RowID,    
g.GroupID,    
GroupNumber,    
g.EffectiveDate GroupEffDate,    
PolicyTypeID,    
PolicySystemCode,    
pol.[Name],    
pol.VendorName,    
pol.EffectiveDate PolEffDate,    
pol.TerminationDate PolTermDate,    
FinancialProductCode,    
FinancialProduct2Code,    
RiskType,    
Panel,    
LegalEntity    
    
Into #GroupPolicies    
From [Group] g    
Inner Join Policy pol    
On g.GroupID = pol.GroupID    
--Group By g.GroupID,GroupNumber,g.EffectiveDate,PolicyTypeID    
--Where g.GroupID = 26    
Order By GroupNumber,g.EffectiveDate,PolicyTypeID    
    
create clustered index PK_GroupPoliciesID on dbo.#GroupPolicies    
(GroupID)    
    
--Select * from #GroupPolicies Where GroupID = 26    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupPolicies]') AND type in (N'U'))    
DELETE FROM [dbo].[Temp_GroupPolicies]  
  
Insert Into dbo.Temp_GroupPolicies   (GroupID  
,GroupNumber  
,GroupEffDate  
,MedicalPolicy  
,MedicalName  
,MedicalVendorName  
,MedicalEffDate  
,MedicalTermDate  
,MedicalFinancialProductCode  
,MedicalFinancialProduct2Code  
,MedicalRiskType  
,MedicalPanel  
,MedicalLegalEntity  
,RxPolicy  
,RxName  
,RxVendorName  
,RxEffDate  
,RxTermDate  
,RxFinancialProductCode  
,RxFinancialProduct2Code  
,RxRiskType  
,RxPanel  
,RxLegalEntity  
,DeluxePolicy  
,DeluxeName  
,DeluxeVendorName  
,DeluxeEffDate  
,DeluxeTermDate  
,DeluxeFinancialProductCode  
,DeluxeFinancialProduct2Code  
,DeluxeRiskType  
,DeluxePanel  
,DeluxeLegalEntity  
,DentalPolicy  
,DentalName  
,DentalVendorName  
,DentalEffDate  
,DentalTermDate  
,DentalFinancialProductCode  
,DentalFinancialProduct2Code  
,DentalRiskType  
,DentalPanel  
,DentalLegalEntity  
,VisionPolicy  
,VisionName  
,VisionVendorName  
,VisionEffDate  
,VisionTermDate  
,VisionFinancialProductCode  
,VisionFinancialProduct2Code  
,VisionRiskType  
,VisionPanel  
,VisionLegalEntity  
,MHSAPolicy  
,MHSAName  
,MHSAVendorName  
,MHSAEffDate  
,MHSATermDate  
,MHSAFinancialProductCode  
,MHSAFinancialProduct2Code  
,MHSARiskType  
,MHSAPanel  
,MHSALegalEntity  
,ATWPolicy  
,ATWName  
,ATWVendorName  
,ATWEffDate  
,ATWTermDate  
,ATWFinancialProductCode  
,ATWFinancialProduct2Code  
,ATWRiskType  
,ATWPanel  
,ATWLegalEntity  
,RespitePolicy  
,RespiteName  
,RespiteVendorName  
,RespiteEffDate  
,RespiteTermDate  
,RespiteFinancialProductCode  
,RespiteFinancialProduct2Code  
,RespiteRiskType  
,RespitePanel  
,RespiteLegalEntity  
,ChiroPolicy  
,ChiroName  
,ChiroVendorName  
,ChiroEffDate  
,ChiroTermDate  
,ChiroFinancialProductCode  
,ChiroFinancialProduct2Code  
,ChiroRiskType  
,ChiroPanel  
,ChiroLegalEntity  
,ACUPolicy  
,ACUName  
,ACUVendorName  
,ACUEffDate  
,ACUTermDate  
,ACUFinancialProductCode  
,ACUFinancialProduct2Code  
,ACURiskType  
,ACUPanel  
,ACULegalEntity  
,MassagePolicy  
,MassageName  
,MassageVendorName  
,MassageEffDate  
,MassageTermDate  
,MassageFinancialProductCode  
,MassageFinancialProduct2Code  
,MassageRiskType  
,MassagePanel  
,MassageLegalEntity  
,FitnessPolicy  
,FitnessName  
,FitnessVendorName  
,FitnessEffDate  
,FitnessTermDate  
,FitnessFinancialProductCode  
,FitnessFinancialProduct2Code  
,FitnessRiskType  
,FitnessPanel  
,FitnessLegalEntity  
,HearingPolicy  
,HearingName  
,HearingVendorName  
,HearingEffDate  
,HearingTermDate  
,HearingFinancialProductCode  
,HearingFinancialProduct2Code  
,HearingRiskType  
,HearingPanel  
,HearingLegalEntity  
,PodiatryPolicy  
,PodiatryName  
,PodiatryVendorName  
,PodiatryEffDate  
,PodiatryTermDate  
,PodiatryFinancialProductCode  
,PodiatryFinancialProduct2Code  
,PodiatryRiskType  
,PodiatryPanel  
,PodiatryLegalEntity  
,NonEmergencyPolicy  
,NonEmergencyName  
,NonEmergencyVendorName  
,NonEmergencyEffDate  
,NonEmergencyTermDate  
,NonEmergencyFinancialProductCode  
,NonEmergencyFinancialProduct2Code  
,NonEmergencyRiskType  
,NonEmergencyPanel  
,NonEmergencyLegalEntity  
,PHBPolicy  
,PHBName  
,PHBVendorName  
,PHBEffDate  
,PHBTermDate  
,PHBFinancialProductCode  
,PHBFinancialProduct2Code  
,PHBRiskType  
,PHBPanel  
,PHBLegalEntity  
,NurselinePolicy  
,NurselineName  
,NurselineVendorName  
,NurselineEffDate  
,NurselineTermDate  
,NurselineFinancialProductCode  
,NurselineFinancialProduct2Code  
,NurselineRiskType  
,NurselinePanel  
,NurselineLegalEntity  
,CaregiverPolicy  
,CaregiverName  
,CaregiverVendorName  
,CaregiverEffDate  
,CaregiverTermDate  
,CaregiverFinancialProductCode  
,CaregiverFinancialProduct2Code  
,CaregiverRiskType  
,CaregiverPanel  
,CaregiverLegalEntity  
,WellnessPolicy  
,WellnessName  
,WellnessVendorName  
,WellnessEffDate  
,WellnessTermDate  
,WellnessFinancialProductCode  
,WellnessFinancialProduct2Code  
,WellnessRiskType  
,WellnessPanel  
,WellnessLegalEntity  
,NutritionPolicy  
,NutritionName  
,NutritionVendorName  
,NutritionEffDate  
,NutritionTermDate  
,NutritionFinancialProductCode  
,NutritionFinancialProduct2Code  
,NutritionRiskType  
,NutritionPanel  
,NutritionLegalEntity  
,PlusPolicy  
,PlusName  
,PlusVendorName  
,PlusEffDate  
,PlusTermDate  
,PlusFinancialProductCode  
,PlusFinancialProduct2Code  
,PlusRiskType  
,PlusPanel  
,PlusLegalEntity  
,Dental260Policy  
,Dental260Name  
,Dental260VendorName  
,Dental260EffDate  
,Dental260TermDate  
,Dental260FinancialProductCode  
,Dental260FinancialProduct2Code  
,Dental260RiskType  
,Dental260Panel  
,Dental260LegalEntity  
,Dental466Policy  
,Dental466Name  
,Dental466VendorName  
,Dental466EffDate  
,Dental466TermDate  
,Dental466FinancialProductCode  
,Dental466FinancialProduct2Code  
,Dental466RiskType  
,Dental466Panel  
,Dental466LegalEntity  
,Dental467Policy  
,Dental467Name  
,Dental467VendorName  
,Dental467EffDate  
,Dental467TermDate  
,Dental467FinancialProductCode  
,Dental467FinancialProduct2Code  
,Dental467RiskType  
,Dental467Panel  
,Dental467LegalEntity  
,Dental469Policy  
,Dental469Name  
,Dental469VendorName  
,Dental469EffDate  
,Dental469TermDate  
,Dental469FinancialProductCode  
,Dental469FinancialProduct2Code  
,Dental469RiskType  
,Dental469Panel  
,Dental469LegalEntity  
,DentalGoldPolicy  
,DentalGoldName  
,DentalGoldVendorName  
,DentalGoldEffDate  
,DentalGoldTermDate  
,DentalGoldFinancialProductCode  
,DentalGoldFinancialProduct2Code  
,DentalGoldRiskType  
,DentalGoldPanel  
,DentalGoldLegalEntity  
,DentalSilverPolicy  
,DentalSilverName  
,DentalSilverVendorName  
,DentalSilverEffDate  
,DentalSilverTermDate  
,DentalSilverFinancialProductCode  
,DentalSilverFinancialProduct2Code  
,DentalSilverRiskType  
,DentalSilverPanel  
,DentalSilverLegalEntity  
,HighOptionDentalPolicy  
,HighOptionDentalName  
,HighOptionDentalVendorName  
,HighOptionDentalEffDate  
,HighOptionDentalTermDate  
,HighOptionDentalFinancialProductCode  
,HighOptionDentalFinancialProduct2Code  
,HighOptionDentalRiskType  
,HighOptionDentalPanel  
,HighOptionDentalLegalEntity  
,OptionalDentalPolicy  
,OptionalDentalName  
,OptionalDentalVendorName  
,OptionalDentalEffDate  
,OptionalDentalTermDate  
,OptionalDentalFinancialProductCode  
,OptionalDentalFinancialProduct2Code  
,OptionalDentalRiskType  
,OptionalDentalPanel  
,OptionalDentalLegalEntity  
,DentalPlatinumPolicy  
,DentalPlatinumName  
,DentalPlatinumVendorName  
,DentalPlatinumEffDate  
,DentalPlatinumTermDate  
,DentalPlatinumFinancialProductCode  
,DentalPlatinumFinancialProduct2Code  
,DentalPlatinumRiskType  
,DentalPlatinumPanel  
,DentalPlatinumLegalEntity  
,CreateBy  
,CreateDate)  
Select Distinct    
--g.RowID,    
g.GroupID,g.GroupNumber,g.GroupEffDate,    
-- Medical    
g1.PolicySystemCode MedicalPolicy,g1.[Name] MedicalName,g1.vendorname MedicalVendorName,g1.PolEffDate MedicalEffDate,g1.PolTermDate MedicalTermDate,    
g1.FinancialProductCode MedicalFinancialProductCode,g1.FinancialProduct2Code MedicalFinancialProduct2Code,    
g1.RiskType MedicalRiskType,g1.Panel MedicalPanel,g1.LegalEntity MedicalLegalEntity,    
-- Rx    
g4.PolicySystemCode RxPolicy,g4.[Name] RxName,g4.vendorname RxVendorName,g4.PolEffDate RxEffDate,g4.PolTermDate RxTermDate,    
g4.FinancialProductCode RxFinancialProductCode,g4.FinancialProduct2Code RxFinancialProduct2Code,    
g4.RiskType RxRiskType,g4.Panel RxPanel,g4.LegalEntity RxLegalEntity,    
-- Deluxe    
g6.PolicySystemCode DeluxePolicy,g6.[Name] DeluxeName,g6.vendorname DeluxeVendorName,g6.PolEffDate DeluxeEffDate,g6.PolTermDate DeluxeTermDate,    
g6.FinancialProductCode DeluxeFinancialProductCode,g6.FinancialProduct2Code DeluxeFinancialProduct2Code,    
g6.RiskType DeluxeRiskType,g6.Panel DeluxePanel,g6.LegalEntity DeluxeLegalEntity,    
-- Dental    
g2.PolicySystemCode DentalPolicy,g2.[Name] DentalName,g2.vendorname DentalVendorName,g2.PolEffDate DentalEffDate,g2.PolTermDate DentalTermDate,    
g2.FinancialProductCode DentalFinancialProductCode,g2.FinancialProduct2Code DentalFinancialProduct2Code,    
g2.RiskType DentalRiskType,g2.Panel DentalPanel,g2.LegalEntity DentalLegalEntity,    
-- Vision    
g3.PolicySystemCode VisionPolicy,g3.[Name] VisionName,g3.vendorname VisionVendorName,g3.PolEffDate VisionEffDate,g3.PolTermDate VisionTermDate,    
g3.FinancialProductCode VisionFinancialProductCode,g3.FinancialProduct2Code VisionFinancialProduct2Code,    
g3.RiskType VisionRiskType,g3.Panel VisionPanel,g3.LegalEntity VisionLegalEntity,    
-- MHSA    
g5.PolicySystemCode MHSAPolicy,g5.[Name] MHSAName,g5.vendorname MHSAVendorName,g5.PolEffDate MHSAEffDate,g5.PolTermDate MHSATermDate,    
g5.FinancialProductCode MHSAFinancialProductCode,g5.FinancialProduct2Code MHSAFinancialProduct2Code,    
g5.RiskType MHSARiskType,g5.Panel MHSAPanel,g5.LegalEntity MHSALegalEntity,    
-- ATW    
g7.PolicySystemCode ATWPolicy,g7.[Name] ATWName,g7.vendorname ATWVendorName,g7.PolEffDate ATWEffDate,g7.PolTermDate ATWTermDate,    
g7.FinancialProductCode ATWFinancialProductCode,g7.FinancialProduct2Code ATWFinancialProduct2Code,    
g7.RiskType ATWRiskType,g7.Panel ATWPanel,g7.LegalEntity ATWLegalEntity,    
-- Respite    
g8.PolicySystemCode RespitePolicy,g8.[Name] RespiteName,g8.vendorname RespiteVendorName,g8.PolEffDate RespiteEffDate,g8.PolTermDate RespiteTermDate,    
g8.FinancialProductCode RespiteFinancialProductCode,g8.FinancialProduct2Code RespiteFinancialProduct2Code,    
g8.RiskType RespiteRiskType,g8.Panel RespitePanel,g8.LegalEntity RespiteLegalEntity,    
-- Chiro    
g9.PolicySystemCode ChiroPolicy,g9.[Name] ChiroName,g9.vendorname ChiroVendorName,g9.PolEffDate ChiroEffDate,g9.PolTermDate ChiroTermDate,    
g9.FinancialProductCode ChiroFinancialProductCode,g9.FinancialProduct2Code ChiroFinancialProduct2Code,    
g9.RiskType ChiroRiskType,g9.Panel ChiroPanel,g9.LegalEntity ChiroLegalEntity,    
-- ACU    
g10.PolicySystemCode ACUPolicy,g10.[Name] ACUName,g10.vendorname ACUVendorName,g10.PolEffDate ACUEffDate,g10.PolTermDate ACUTermDate,    
g10.FinancialProductCode ACUFinancialProductCode,g10.FinancialProduct2Code ACUFinancialProduct2Code,    
g10.RiskType ACURiskType,g10.Panel ACUPanel,g10.LegalEntity ACULegalEntity,    
-- Massage    
g11.PolicySystemCode MassagePolicy,g11.[Name] MassageName,g11.vendorname MassageVendorName,g11.PolEffDate MassageEffDate,g11.PolTermDate MassageTermDate,    
g11.FinancialProductCode MassageFinancialProductCode,g11.FinancialProduct2Code MassageFinancialProduct2Code,    
g11.RiskType MassageRiskType,g11.Panel MassagePanel,g11.LegalEntity MassageLegalEntity,    
-- Fitness    
g12.PolicySystemCode FitnessPolicy,g12.[Name] FitnessName,g12.vendorname FitnessVendorName,g12.PolEffDate FitnessEffDate,g12.PolTermDate FitnessTermDate,    
g12.FinancialProductCode FitnessFinancialProductCode,g12.FinancialProduct2Code FitnessFinancialProduct2Code,    
g12.RiskType FitnessRiskType,g12.Panel FitnessPanel,g12.LegalEntity FitnessLegalEntity,    
-- Hearing    
g13.PolicySystemCode HearingPolicy,g13.[Name] HearingName,g13.vendorname HearingVendorName,g13.PolEffDate HearingEffDate,g13.PolTermDate HearingTermDate,    
g13.FinancialProductCode HearingFinancialProductCode,g13.FinancialProduct2Code HearingFinancialProduct2Code,    
g13.RiskType HearingRiskType,g13.Panel HearingPanel,g13.LegalEntity HearingLegalEntity,    
-- Podiatry    
g14.PolicySystemCode PodiatryPolicy,g14.[Name] PodiatryName,g14.vendorname PodiatryVendorName,g14.PolEffDate PodiatryEffDate,g14.PolTermDate PodiatryTermDate,    
g14.FinancialProductCode PodiatryFinancialProductCode,g14.FinancialProduct2Code PodiatryFinancialProduct2Code,    
g14.RiskType PodiatryRiskType,g14.Panel PodiatryPanel,g14.LegalEntity PodiatryLegalEntity,    
-- Podiatry    
g15.PolicySystemCode NonEmergencyPolicy,g15.[Name] NonEmergencyName,g15.vendorname NonEmergencyVendorName,g15.PolEffDate NonEmergencyEffDate,g15.PolTermDate NonEmergencyTermDate,    
g15.FinancialProductCode NonEmergencyFinancialProductCode,g15.FinancialProduct2Code NonEmergencyFinancialProduct2Code,    
g15.RiskType NonEmergencyRiskType,g15.Panel NonEmergencyPanel,g15.LegalEntity NonEmergencyLegalEntity,    
-- PHB    
g16.PolicySystemCode PHBPolicy,g16.[Name] PHBName,g16.vendorname PHBVendorName,g16.PolEffDate PHBEffDate,g16.PolTermDate PHBTermDate,    
g16.FinancialProductCode PHBFinancialProductCode,g16.FinancialProduct2Code PHBFinancialProduct2Code,    
g16.RiskType PHBRiskType,g16.Panel PHBPanel,g16.LegalEntity PHBLegalEntity,    
-- NurseLine    
g17.PolicySystemCode NurselinePolicy,g17.[Name] NurselineName,g17.vendorname NurselineVendorName,g17.PolEffDate NurselineEffDate,g17.PolTermDate NurselineTermDate,    
g17.FinancialProductCode NurselineFinancialProductCode,g17.FinancialProduct2Code NurselineFinancialProduct2Code,    
g17.RiskType NurselineRiskType,g17.Panel NurselinePanel,g17.LegalEntity NurselineLegalEntity,    
-- Caregiver    
g18.PolicySystemCode CaregiverPolicy,g18.[Name] CaregiverName,g18.vendorname CaregiverVendorName,g18.PolEffDate CaregiverEffDate,g18.PolTermDate CaregiverTermDate,    
g18.FinancialProductCode CaregiverFinancialProductCode,g18.FinancialProduct2Code CaregiverFinancialProduct2Code,    
g18.RiskType CaregiverRiskType,g18.Panel CaregiverPanel,g18.LegalEntity CaregiverLegalEntity,    
-- Wellness    
g19.PolicySystemCode WellnessPolicy,g19.[Name] WellnessName,g19.vendorname WellnessVendorName,g19.PolEffDate WellnessEffDate,g19.PolTermDate WellnessTermDate,    
g19.FinancialProductCode WellnessFinancialProductCode,g19.FinancialProduct2Code WellnessFinancialProduct2Code,    
g19.RiskType WellnessRiskType,g19.Panel WellnessPanel,g19.LegalEntity WellnessLegalEntity,    
-- Nutrition    
g20.PolicySystemCode NutritionPolicy,g20.[Name] NutritionName,g20.vendorname NutritionVendorName,g20.PolEffDate NutritionEffDate,g20.PolTermDate NutritionTermDate,    
g20.FinancialProductCode NutritionFinancialProductCode,g20.FinancialProduct2Code NutritionFinancialProduct2Code,    
g20.RiskType NutritionRiskType,g20.Panel NutritionPanel,g20.LegalEntity NutritionLegalEntity,    
-- Plus    
g24.PolicySystemCode PlusPolicy,g24.[Name] PlusName,g24.vendorname PlusVendorName,g24.PolEffDate PlusEffDate,g24.PolTermDate PlusTermDate,    
g24.FinancialProductCode PlusFinancialProductCode,g24.FinancialProduct2Code PlusFinancialProduct2Code,    
g24.RiskType PlusRiskType,g24.Panel PlusPanel,g24.LegalEntity PlusLegalEntity,    
--Other Dental Policies    
-- Dental260    
g25.PolicySystemCode Dental260Policy,g25.[Name] Dental260Name,g25.vendorname Dental260VendorName,g25.PolEffDate Dental260EffDate,g25.PolTermDate Dental260TermDate,    
g25.FinancialProductCode Dental260FinancialProductCode,g25.FinancialProduct2Code Dental260FinancialProduct2Code,    
g25.RiskType Dental260RiskType,g25.Panel Dental260Panel,g25.LegalEntity Dental260LegalEntity,    
-- Dental466    
g26.PolicySystemCode Dental466Policy,g26.[Name] Dental466Name,g26.vendorname Dental466VendorName,g26.PolEffDate Dental466EffDate,g26.PolTermDate Dental466TermDate,    
g26.FinancialProductCode Dental466FinancialProductCode,g26.FinancialProduct2Code Dental466FinancialProduct2Code,    
g26.RiskType Dental466RiskType,g26.Panel Dental466Panel,g26.LegalEntity Dental466LegalEntity,    
-- Dental467    
g27.PolicySystemCode Dental467Policy,g27.[Name] Dental467Name,g27.vendorname Dental467VendorName,g27.PolEffDate Dental467EffDate,g27.PolTermDate Dental467TermDate,    
g27.FinancialProductCode Dental467FinancialProductCode,g27.FinancialProduct2Code Dental467FinancialProduct2Code,    
g27.RiskType Dental467RiskType,g27.Panel Dental467Panel,g27.LegalEntity Dental467LegalEntity,    
-- Dental469    
g28.PolicySystemCode Dental469Policy,g28.[Name] Dental469Name,g28.vendorname Dental469VendorName,g28.PolEffDate Dental469EffDate,g28.PolTermDate Dental469TermDate,    
g28.FinancialProductCode Dental469FinancialProductCode,g28.FinancialProduct2Code Dental469FinancialProduct2Code,    
g28.RiskType Dental469RiskType,g28.Panel Dental469Panel,g28.LegalEntity Dental469LegalEntity,    
-- DentalGold    
g29.PolicySystemCode DentalGoldPolicy,g29.[Name] DentalGoldName,g29.vendorname DentalGoldVendorName,g29.PolEffDate DentalGoldEffDate,g29.PolTermDate DentalGoldTermDate,    
g29.FinancialProductCode DentalGoldFinancialProductCode,g29.FinancialProduct2Code DentalGoldFinancialProduct2Code,    
g29.RiskType DentalGoldRiskType,g29.Panel DentalGoldPanel,g29.LegalEntity DentalGoldLegalEntity,    
-- DentalSilver    
g30.PolicySystemCode DentalSilverPolicy,g30.[Name] DentalSilverName,g30.vendorname DentalSilverVendorName,g30.PolEffDate DentalSilverEffDate,g30.PolTermDate DentalSilverTermDate,    
g30.FinancialProductCode DentalSilverFinancialProductCode,g30.FinancialProduct2Code DentalSilverFinancialProduct2Code,    
g30.RiskType DentalSilverRiskType,g30.Panel DentalSilverPanel,g30.LegalEntity DentalSilverLegalEntity,    
-- HighOptionDental    
g31.PolicySystemCode HighOptionDentalPolicy,g31.[Name] HighOptionDentalName,g31.vendorname HighOptionDentalVendorName,g31.PolEffDate HighOptionDentalEffDate,g31.PolTermDate HighOptionDentalTermDate,    
g31.FinancialProductCode HighOptionDentalFinancialProductCode,g31.FinancialProduct2Code HighOptionDentalFinancialProduct2Code,    
g31.RiskType HighOptionDentalRiskType,g31.Panel HighOptionDentalPanel,g31.LegalEntity HighOptionDentalLegalEntity,    
-- OptionalDental    
g32.PolicySystemCode OptionalDentalPolicy,g32.[Name] OptionalDentalName,g32.vendorname OptionalDentalVendorName,g32.PolEffDate OptionalDentalEffDate,g32.PolTermDate OptionalDentalTermDate,    
g32.FinancialProductCode OptionalDentalFinancialProductCode,g32.FinancialProduct2Code OptionalDentalFinancialProduct2Code,    
g32.RiskType OptionalDentalRiskType,g32.Panel OptionalDentalPanel,g32.LegalEntity OptionalDentalLegalEntity,    
-- DentalPlatinum    
g38.PolicySystemCode DentalPlatinumPolicy,g38.[Name] DentalPlatinumName,g38.vendorname DentalPlatinumVendorName,g38.PolEffDate DentalPlatinumEffDate,g38.PolTermDate DentalPlatinumTermDate,    
g38.FinancialProductCode DentalPlatinumFinancialProductCode,g38.FinancialProduct2Code DentalPlatinumFinancialProduct2Code,    
g38.RiskType DentalPlatinumRiskType,g38.Panel DentalPlatinumPanel,g38.LegalEntity DentalPlatinumLegalEntity,    
User as CreateBy,    
Getdate() as CreateDate    
    
   
From #GroupPolicies g    
Full Join #GroupPolicies g1    
On g.GroupID = g1.GroupID and g.RowID = g1.RowID and g1.PolicyTypeID = 1    
Full Join #GroupPolicies g4    
On g.GroupID = g4.GroupID and g.RowID = g4.RowID and g4.PolicyTypeID = 4    
Full Join #GroupPolicies g6    
On g.GroupID = g6.GroupID and g.RowID = g6.RowID and g6.PolicyTypeID = 6    
    
Full Join #GroupPolicies g2    
On g.GroupID = g2.GroupID and g.RowID = g2.RowID and g2.PolicyTypeID = 2    
Full Join #GroupPolicies g3    
On g.GroupID = g3.GroupID and g.RowID = g3.RowID and g3.PolicyTypeID = 3    
Full Join #GroupPolicies g5    
On g.GroupID = g5.GroupID and g.RowID = g5.RowID and g5.PolicyTypeID = 5    
    
Full Join #GroupPolicies g7    
On g.GroupID = g7.GroupID and g.RowID = g7.RowID and g7.PolicyTypeID = 7    
Full Join #GroupPolicies g8    
On g.GroupID = g8.GroupID and g.RowID = g8.RowID and g8.PolicyTypeID = 8    
Full Join #GroupPolicies g9    
On g.GroupID = g9.GroupID and g.RowID = g9.RowID and g9.PolicyTypeID = 9    
    
Full Join #GroupPolicies g10    
On g.GroupID = g10.GroupID and g.RowID = g10.RowID and g10.PolicyTypeID = 10    
Full Join #GroupPolicies g11    
On g.GroupID = g11.GroupID and g.RowID = g11.RowID and g11.PolicyTypeID = 11    
Full Join #GroupPolicies g12    
On g.GroupID = g12.GroupID and g.RowID = g12.RowID and g12.PolicyTypeID = 12    
    
Full Join #GroupPolicies g13    
On g.GroupID = g13.GroupID and g.RowID = g13.RowID and g13.PolicyTypeID = 13    
Full Join #GroupPolicies g14    
On g.GroupID = g14.GroupID and g.RowID = g14.RowID and g14.PolicyTypeID = 14    
Full Join #GroupPolicies g15    
On g.GroupID = g15.GroupID and g.RowID = g15.RowID and g15.PolicyTypeID = 15    
    
Full Join #GroupPolicies g16    
On g.GroupID = g16.GroupID and g.RowID = g16.RowID and g16.PolicyTypeID = 16    
Full Join #GroupPolicies g17    
On g.GroupID = g17.GroupID and g.RowID = g17.RowID and g17.PolicyTypeID = 17    
Full Join #GroupPolicies g18    
On g.GroupID = g18.GroupID and g.RowID = g18.RowID and g18.PolicyTypeID = 18    
Full Join #GroupPolicies g19    
On g.GroupID = g19.GroupID and g.RowID = g19.RowID and g19.PolicyTypeID = 19    
Full Join #GroupPolicies g20    
On g.GroupID = g20.GroupID and g.RowID = g20.RowID and g20.PolicyTypeID = 20    
Full Join #GroupPolicies g24    
On g.GroupID = g24.GroupID and g.RowID = g24.RowID and g24.PolicyTypeID = 24    
--Other Dental Policies    
Full Join #GroupPolicies g25    
On g.GroupID = g25.GroupID and g.RowID = g25.RowID and g25.PolicyTypeID = 25    
Full Join #GroupPolicies g26    
On g.GroupID = g26.GroupID and g.RowID = g26.RowID and g26.PolicyTypeID = 26    
Full Join #GroupPolicies g27    
On g.GroupID = g27.GroupID and g.RowID = g27.RowID and g27.PolicyTypeID = 27    
Full Join #GroupPolicies g28    
On g.GroupID = g28.GroupID and g.RowID = g28.RowID and g28.PolicyTypeID = 28    
Full Join #GroupPolicies g29    
On g.GroupID = g29.GroupID and g.RowID = g29.RowID and g29.PolicyTypeID = 29    
Full Join #GroupPolicies g30    
On g.GroupID = g30.GroupID and g.RowID = g30.RowID and g30.PolicyTypeID = 30    
Full Join #GroupPolicies g31    
On g.GroupID = g31.GroupID and g.RowID = g31.RowID and g31.PolicyTypeID = 31    
Full Join #GroupPolicies g32    
On g.GroupID = g32.GroupID and g.RowID = g32.RowID and g32.PolicyTypeID = 32    
Full Join #GroupPolicies g38    
On g.GroupID = g38.GroupID and g.RowID = g38.RowID and g38.PolicyTypeID = 38    
    
Where g.GroupNumber Is Not Null --and g.GroupID = 26    
order by --g.RowID,    
g.GroupID,g.GroupNumber,g.GroupEffDate    
  
Drop Table #GroupPolicies  