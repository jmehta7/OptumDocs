-- Adding all the Dental benefits as per TT 50345    
--Siva Chavva : 06/01/2009 :Non Clustered Index on [Temp_GroupBenefit]    
--Siva Chavva : 02/02/2009 :Phase III changes as per TT 70376,70377    
--Siva Chavva : 02/13/2009 :Included IsRDSflag as per TT 70247    
--Siva Chavva : 07/15/2009 :Included IsCostShareIndicator as per TT 85792    
-- Siva Chavva:07/27/2009:Included new columns as per TT 70640 for SGE    
-- Siva Chavva:11/17/2009:Included planTypeID as per TT100388    
-- Siva Chavva:11/17/2009:Included CreateBy,CreateDate in table    
-- Vineela Boddula : 06/14/2010: Included IDCardEmployerName in the table    
-- Srini Pallerla: 11/28/2011 : Included Rx/g4 in COALESCE as part of PDP Impacts Project  
-- Jatin 03/13/2019 : Removed index of dbo.Temp_GroupBenSys table , added insert into statement , change from DROP to DELETE for Attunity requirement   
    
CREATE Proc [dbo].[RPT_iGroupBenefits]    
As    
Begin    
--Step 4: Create table for retrieving Group Template info from Benefit table    
--Create temp table containing the unique Benefit Premiums for IndividualGroups    
  
  
create table dbo.#GroupBenefit -- Included by Vineela Boddula : 06/14/2010    
(    
PlanID int,    
GroupID int,    
BenefitID int,    
BenefitTypeId int,    
EffectiveDate datetime,    
PremiumAmount money,    
BrandName varchar(20),    
DrugCoverageType varchar(4),    
PlanLongName varchar(75),     
IsPassportFlag bit,    
IsRDSFlag bit,    
IsCostShareIndicator bit,    
IsOpenAccess bit,    
IsGateKeeper bit,    
IsSpecialistSelfReferral bit,    
IDCardEmployerName varchar(50),    
PlanTypeID int    
)    
Insert Into dbo.#GroupBenefit    
Select Distinct    
       gpb.PlanID,    
       gpb.GroupID,    
    b.BenefitID,    
       b.BenefitTypeId,    
       b.EffectiveDate,    
       b.PremiumAmount,    
       IPD.BrandName,    
       IPD.DrugCoverageType,    
    IPD.PlanLongName,     
    IPD.IsPassportFlag,    
    IPD.IsRDSFlag,    
    IPD.IsCostShareIndicator,    
    IPD.IsOpenAccess,    
    IPD.IsGateKeeper,    
    IPD.IsSpecialistSelfReferral,    
    NULL AS IDCardEmployerName,  -- Included by Vineela Boddula : 06/14/2010  - MAPS ID CARD ELEMENTS    
    P.PlanTypeID     
--into dbo.#GroupBenefit    
from IndividualGroupPlan gpb    
inner join [Plan] p    
 on gpb.PlanID = p.PlanID     
Inner join IndividualPlanBenefit pb    
   on gpb.PlanID = pb.PlanID    
inner join Benefit b    
   on pb.BenefitID = b.BenefitID and NetworkTypeID = 1    
inner join dbo.IndividualPlanDemographic IPD    
 on IPD.PlanID = gpb.PlanID    
    
--Where b.BenefitTypeID In (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,24) get everything    
-- Employer Groups    
Insert Into dbo.#GroupBenefit    
select Distinct    
       egpb.PlanID,    
       egpb.GroupID,    
    b.BenefitID,    
       b.BenefitTypeId,    
       b.EffectiveDate,    
       b.PremiumAmount,    
       EGD.BrandName,    
       EGD.DrugCoverageType,    
    EGD.PlanLongName,     
    EGD.IsPassportFlag,    
    EGD.IsRDSFlag,    
    EGD.IsCostShareIndicator,    
    EGD.IsOpenAccess,    
    EGD.IsGateKeeper,    
    EGD.IsSpecialistSelfReferral,    
    EGD.IDCardEmployerName,  -- Included by Vineela Boddula : 06/14/2010 - MAPS ID CARD ELEMENTS    
    IsNull(EGD.PlanTypeID,p.PlanTypeID) AS PlanTypeID    
    
from EmployerGroupPlanBenefit  egpb    
inner join Benefit b    
   on egpb.BenefitID = b.BenefitID and NetworkTypeID = 1    
inner join [Plan] p    
on egpb.PlanID = p.PlanID     
Inner Join dbo.EmployerGroupDemographic  EGD    
 On EGD.GroupID = egpb.GroupID     
    
Where egpb.GroupID Not In (Select GroupID from #GroupBenefit)    
--and  b.BenefitTypeID In (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,24) get everything    
    
create clustered index PK_GroupBenID on dbo.#GroupBenefit    
(GroupID)    
    
--Use the Temp table to populate a new table to be used in our final query.    
  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupBenefit]') AND type in (N'U'))    
DELETE FROM [dbo].[Temp_GroupBenefit]   
  INSERT Into dbo.Temp_GroupBenefit     (PlanID  
     ,GroupID  
     ,PlanTypeID  
     ,MedicalPremium  
     ,DentalPremium  
     ,VisionPremium  
     ,RxPremium  
     ,MHSAPremium  
     ,DeluxePremium  
     ,ATWPremium  
     ,RespitePremium  
     ,ChiroPremium  
     ,ACUPremium  
     ,MassagePremium  
     ,FitnessPremium  
     ,HearingPremium  
     ,PodiatryPremium  
     ,NonEmergencyPremium  
     ,PHBPremium  
     ,NurselinePremium  
     ,CaregiverPremium  
     ,WellnessPremium  
     ,NutritionPremium  
     ,PlusPremium  
     ,Dental260Premium  
     ,Dental466Premium  
     ,Dental467Premium  
     ,Dental469Premium  
     ,DentalGoldPremium  
     ,DentalSilverPremium  
     ,HighOptionDentalPremium  
     ,OptionalDentalPremium  
     ,DentalPlatinumPremium  
     ,BrandName  
     ,DrugCoverageType  
     ,PlanLongName  
     ,IsPassportFlag  
     ,IsRDSFlag  
     ,IsCostShareIndicator  
     ,IsOpenAccess  
     ,IsGateKeeper  
     ,IsSpecialistSelfReferral  
     ,IDCardEmployerName  
     ,CreateBy  
     ,CreateDate)  
   
Select Distinct    
g.PlanID,    
g.GroupID,    
g.PlanTypeID,    
--g.BenefitID,    
--g.benefittypeID,    
g1.PremiumAmount MedicalPremium,    
g2.PremiumAmount DentalPremium,    
g3.PremiumAmount VisionPremium,    
g4.PremiumAmount RxPremium,    
g5.PremiumAmount MHSAPremium,    
g6.PremiumAmount DeluxePremium,    
g7.PremiumAmount ATWPremium,    
g8.PremiumAmount RespitePremium,    
g9.PremiumAmount ChiroPremium,    
g10.PremiumAmount ACUPremium,    
g11.PremiumAmount MassagePremium,    
g12.PremiumAmount FitnessPremium,    
g13.PremiumAmount HearingPremium,    
g14.PremiumAmount PodiatryPremium,    
g15.PremiumAmount NonEmergencyPremium,    
g16.PremiumAmount PHBPremium,    
g17.PremiumAmount NurselinePremium,    
g18.PremiumAmount CaregiverPremium,    
g19.PremiumAmount WellnessPremium,    
g20.PremiumAmount NutritionPremium,    
g24.PremiumAmount PlusPremium,    
-- Added as per TT 50345    
g25.PremiumAmount Dental260Premium,    
g26.PremiumAmount Dental466Premium,    
g27.PremiumAmount Dental467Premium,    
g28.PremiumAmount Dental469Premium,    
g29.PremiumAmount DentalGoldPremium,    
g30.PremiumAmount DentalSilverPremium,    
g31.PremiumAmount HighOptionDentalPremium,    
g32.PremiumAmount OptionalDentalPremium,    
g38.PremiumAmount DentalPlatinumPremium,    
Coalesce(g1.BrandName,g2.BrandName,g4.BrandName) as BrandName,   -- Changed as GPS was seeing duplicates    
Coalesce(g1.DrugCoverageType,g2.DrugCoverageType,g4.DrugCoverageType) as DrugCoverageType, -- Changed as GPS was seeing duplicates    
Coalesce(g1.PlanLongName,g2.PlanLongName,g4.PlanLongName) as PlanLongName,     
Coalesce(g1.IsPassportFlag,g2.IsPassportFlag,g4.IsPassportFlag) as  IsPassportFlag,      -- Changed to Medical record as per TT 49181    
Coalesce(g1.IsRDSFlag,g2.IsRDSFlag,g4.IsRDSFlag) as IsRDSFlag,    
Coalesce(g1.IsCostShareIndicator,g2.IsCostShareIndicator,g4.IsCostShareIndicator) as IsCostShareIndicator,    
Coalesce(g1.IsOpenAccess,g2.IsOpenAccess,g4.IsOpenAccess) as IsOpenAccess,    
Coalesce(g1.IsGateKeeper,g2.IsGateKeeper,g4.IsGateKeeper) as IsGateKeeper,    
Coalesce(g1.IsSpecialistSelfReferral,g2.IsSpecialistSelfReferral,g4.IsSpecialistSelfReferral) as IsSpecialistSelfReferral,    
g.IDCardEmployerName, -- Included by Vineela Boddula : 06/14/2010 - MAPS ID CARD ELEMENTS    
User as CreateBy,    
Getdate() as CreateDate    
    
  
from #GroupBenefit g    
Left join #GroupBenefit g1    
On g.GroupID = g1.GroupID and g1.BenefitTypeID = 1 and g.PlanID = g1.PlanID    
Left join #GroupBenefit g2    
On g.GroupID = g2.GroupID and g2.BenefitTypeID = 2 and g.PlanID = g2.PlanID    
Left join #GroupBenefit g3    
On g.GroupID = g3.GroupID and g3.BenefitTypeID = 3 and g.PlanID = g3.PlanID    
Left join #GroupBenefit g4    
On g.GroupID = g4.GroupID and g4.BenefitTypeID = 4 and g.PlanID = g4.PlanID    
Left join #GroupBenefit g5    
On g.GroupID = g5.GroupID and g5.BenefitTypeID = 5 and g.PlanID = g5.PlanID    
Left join #GroupBenefit g6    
On g.GroupID = g6.GroupID and g6.BenefitTypeID = 6 and g.PlanID = g6.PlanID    
Left join #GroupBenefit g7    
On g.GroupID = g7.GroupID and g7.BenefitTypeID = 7 and g.PlanID = g7.PlanID    
Left join #GroupBenefit g8    
On g.GroupID = g8.GroupID and g8.BenefitTypeID = 8 and g.PlanID = g8.PlanID    
Left join #GroupBenefit g9    
On g.GroupID = g9.GroupID and g9.BenefitTypeID = 9 and g.PlanID = g9.PlanID    
Left join #GroupBenefit g10    
On g.GroupID = g10.GroupID and g10.BenefitTypeID = 10 and g.PlanID = g10.PlanID    
Left join #GroupBenefit g11    
On g.GroupID = g11.GroupID and g11.BenefitTypeID = 11 and g.PlanID = g11.PlanID    
Left join #GroupBenefit g12     
On g.GroupID = g12.GroupID and g12.BenefitTypeID = 12 and g.PlanID = g12.PlanID    
Left join #GroupBenefit g13    
On g.GroupID = g13.GroupID and g13.BenefitTypeID = 13 and g.PlanID = g13.PlanID    
Left join #GroupBenefit g14    
On g.GroupID = g14.GroupID and g14.BenefitTypeID = 14 and g.PlanID = g14.PlanID    
Left join #GroupBenefit g15    
On g.GroupID = g15.GroupID and g15.BenefitTypeID = 15 and g.PlanID = g15.PlanID    
Left join #GroupBenefit g16    
On g.GroupID = g16.GroupID and g16.BenefitTypeID = 16 and g.PlanID = g16.PlanID    
Left join #GroupBenefit g17    
On g.GroupID = g17.GroupID and g17.BenefitTypeID = 17 and g.PlanID = g17.PlanID    
Left join #GroupBenefit g18    
On g.GroupID = g18.GroupID and g18.BenefitTypeID = 18 and g.PlanID = g18.PlanID    
Left join #GroupBenefit g19    
On g.GroupID = g19.GroupID and g19.BenefitTypeID = 19 and g.PlanID = g19.PlanID    
Left join #GroupBenefit g20    
On g.GroupID = g20.GroupID and g20.BenefitTypeID = 20 and g.PlanID = g20.PlanID    
Left join #GroupBenefit g24    
On g.GroupID = g24.GroupID and g24.BenefitTypeID = 24 and g.PlanID = g24.PlanID    
-- Added as per TT 50345    
Left join #GroupBenefit g25    
On g.GroupID = g25.GroupID and g25.BenefitTypeID = 25 and g.PlanID = g25.PlanID    
Left join #GroupBenefit g26    
On g.GroupID = g26.GroupID and g26.BenefitTypeID = 26 and g.PlanID = g26.PlanID    
Left join #GroupBenefit g27    
On g.GroupID = g27.GroupID and g27.BenefitTypeID = 27 and g.PlanID = g27.PlanID    
Left join #GroupBenefit g28    
On g.GroupID = g28.GroupID and g28.BenefitTypeID = 28 and g.PlanID = g28.PlanID    
Left join #GroupBenefit g29    
On g.GroupID = g29.GroupID and g29.BenefitTypeID = 29 and g.PlanID = g29.PlanID    
Left join #GroupBenefit g30    
On g.GroupID = g30.GroupID and g30.BenefitTypeID = 30 and g.PlanID = g30.PlanID    
Left join #GroupBenefit g31    
On g.GroupID = g31.GroupID and g31.BenefitTypeID = 31 and g.PlanID = g31.PlanID    
Left join #GroupBenefit g32    
On g.GroupID = g32.GroupID and g32.BenefitTypeID = 32 and g.PlanID = g32.PlanID    
Left join #GroupBenefit g38    
On g.GroupID = g38.GroupID and g38.BenefitTypeID = 38 and g.PlanID = g38.PlanID    
    
End    
    
Drop Table dbo.#GroupBenefit    