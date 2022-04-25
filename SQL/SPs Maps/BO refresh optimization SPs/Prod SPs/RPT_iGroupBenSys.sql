-- Commenting and g.beneffdate = g1.beneffdate as we won't receive any dates from the CoreSystem feed which is     
-- making the duplicate recods in GPS,StandardGroupExtact, Extract Group Template etc.    
-- Siva Chavva : 06/01/2009 :Non Clustered Index on [Temp_GroupBenSys]    
-- Siva Chavva:11/17/2009:Included CreateBy,CreateDate in table    
-- Jatin 03/13/2019 : Removed index of dbo.Temp_GroupBenSys table , added insert into statement , change from DROP to DELETE for Attunity requirement   
  
CREATE Proc [dbo].[RPT_iGroupBenSys]    
As    
Select Distinct     
row_number() over (partition by g.GroupID,BenefitTypeID    
                   order by GroupNumber,g.EffectiveDate) RowID,    
g.GroupID,    
bsc.PlanID,    
GroupNumber,    
g.EffectiveDate GroupEffDate,    
BenefitTypeID,    
BenefitSystemCode,    
bsc.EffectiveDate BenEffDate,    
bsc.TerminationDate BenTermDate    
Into #GroupBenSys    
From [Group] g    
Inner Join GroupCoreSystemBenefit gsc    
On g.GroupID = gsc.GroupID    
Inner Join CoreSystemBenefit bsc    
On gsc.CoreSystemBenefitID = bsc.CoreSystemBenefitID    
--Group By g.GroupID,GroupNumber,g.EffectiveDate,BenefitTypeID    
--Where g.GroupID = 26    
Where g.EffectiveDate <> IsNull(g.TerminationDate,'9999-12-31')    
Order By GroupNumber,g.EffectiveDate,BenefitTypeID    
    
create clustered index PK_GroupBenSysID on dbo.#GroupBenSys    
(GroupID)    
    
--Select * from #GroupBenSys Where GroupID = 26    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupBenSys]') AND type in (N'U'))    
DELETE FROM [dbo].[Temp_GroupBenSys]    
  
Insert into [dbo].[Temp_GroupBenSys]  (GroupID  
         ,PlanID  
         ,GroupNumber  
         ,GroupEffDate  
         ,MedicalBenSys  
         ,MedicalEffDate  
         ,MedicalTermDate  
         ,RxBenSys  
         ,RxEffDate  
         ,RxTermDate  
         ,DeluxeBenSys  
         ,DeluxeEffDate  
         ,DeluxeTermDate  
         ,DentalBenSys  
         ,DentalEffDate  
         ,DentalTermDate  
         ,VisionBenSys  
         ,VisionEffDate  
         ,VisionTermDate  
         ,MHSABenSys  
         ,MHSAEffDate  
         ,MHSATermDate  
         ,ATWBenSys  
         ,ATWEffDate  
         ,ATWTermDate  
         ,RespiteBenSys  
         ,RespiteEffDate  
         ,RespiteTermDate  
         ,ChiroBenSys  
         ,ChiroEffDate  
         ,ChiroTermDate  
         ,ACUBenSys  
         ,ACUEffDate  
         ,ACUTermDate  
         ,MassageBenSys  
         ,MassageEffDate  
         ,MassageTermDate  
         ,FitnessBenSys  
         ,FitnessEffDate  
         ,FitnessTermDate  
         ,HearingBenSys  
         ,HearingEffDate  
         ,HearingTermDate  
         ,PodiatryBenSys  
         ,PodiatryEffDate  
         ,PodiatryTermDate  
         ,NonEmergencyBenSys  
         ,NonEmergencyEffDate  
         ,NonEmergencyTermDate  
         ,PHBBenSys  
         ,PHBEffDate  
         ,PHBTermDate  
         ,NurseLineBenSys  
         ,NurseLineEffDate  
         ,NurseLineTermDate  
         ,CareGiverBenSys  
         ,CareGiverEffDate  
         ,CareGiverTermDate  
         ,WellnessBenSys  
         ,WellnessEffDate  
         ,WellnessTermDate  
         ,NutritionBenSys  
         ,NutritionEffDate  
         ,NutritionTermDate  
         ,PlusBenSys  
         ,PlusEffDate  
         ,PlusTermDate  
         ,Dental260BenSys  
         ,Dental260EffDate  
         ,Dental260TermDate  
         ,Dental466BenSys  
         ,Dental466EffDate  
         ,Dental466TermDate  
         ,Dental467BenSys  
         ,Dental467EffDate  
         ,Dental467TermDate  
         ,Dental469BenSys  
         ,Dental469EffDate  
         ,Dental469TermDate  
         ,DentalGoldBenSys  
         ,DentalGoldEffDate  
         ,DentalGoldTermDate  
         ,DentalSilverBenSys  
         ,DentalSilverEffDate  
         ,DentalSilverTermDate  
         ,HighOptionDentalBenSys  
         ,HighOptionDentalEffDate  
         ,HighOptionDentalTermDate  
         ,OptionalDentalBenSys  
         ,OptionalDentalEffDate  
         ,OptionalDentalTermDate  
         ,DentalPlatinumBenSys  
         ,DentalPlatinumEffDate  
         ,DentalPlatinumTermDate  
         ,CreateBy  
         ,CreateDate  
       )  
Select Distinct    
--g.RowID,    
g.GroupID,    
g.PlanID,    
g.GroupNumber,g.GroupEffDate,    
g1.BenefitSystemCode MedicalBenSys,g1.BenEffDate MedicalEffDate,g1.BenTermDate MedicalTermDate,    
g4.BenefitSystemCode RxBenSys,g4.BenEffDate RxEffDate,g4.BenTermDate RxTermDate,    
g6.BenefitSystemCode DeluxeBenSys,g6.BenEffDate DeluxeEffDate,g6.BenTermDate DeluxeTermDate,    
g2.BenefitSystemCode DentalBenSys,g2.BenEffDate DentalEffDate,g2.BenTermDate DentalTermDate,    
g3.BenefitSystemCode VisionBenSys,g3.BenEffDate VisionEffDate,g3.BenTermDate VisionTermDate,    
g5.BenefitSystemCode MHSABenSys,g5.BenEffDate MHSAEffDate,g5.BenTermDate MHSATermDate,    
g7.BenefitSystemCode ATWBenSys,g7.BenEffDate ATWEffDate,g7.BenTermDate ATWTermDate,    
g8.BenefitSystemCode RespiteBenSys,g8.BenEffDate RespiteEffDate,g8.BenTermDate RespiteTermDate,    
g9.BenefitSystemCode ChiroBenSys,g9.BenEffDate ChiroEffDate,g9.BenTermDate ChiroTermDate,    
g10.BenefitSystemCode ACUBenSys,g10.BenEffDate ACUEffDate,g10.BenTermDate ACUTermDate,    
g11.BenefitSystemCode MassageBenSys,g11.BenEffDate MassageEffDate,g11.BenTermDate MassageTermDate,    
g12.BenefitSystemCode FitnessBenSys,g12.BenEffDate FitnessEffDate,g12.BenTermDate FitnessTermDate,    
g13.BenefitSystemCode HearingBenSys,g13.BenEffDate HearingEffDate,g13.BenTermDate HearingTermDate,    
g14.BenefitSystemCode PodiatryBenSys,g14.BenEffDate PodiatryEffDate,g14.BenTermDate PodiatryTermDate,    
g15.BenefitSystemCode NonEmergencyBenSys,g15.BenEffDate NonEmergencyEffDate,g15.BenTermDate NonEmergencyTermDate,    
g16.BenefitSystemCode PHBBenSys,g16.BenEffDate PHBEffDate,g16.BenTermDate PHBTermDate,    
g17.BenefitSystemCode NurseLineBenSys,g17.BenEffDate NurseLineEffDate,g17.BenTermDate NurseLineTermDate,    
g18.BenefitSystemCode CareGiverBenSys,g18.BenEffDate CareGiverEffDate,g18.BenTermDate CareGiverTermDate,    
g19.BenefitSystemCode WellnessBenSys,g19.BenEffDate WellnessEffDate,g19.BenTermDate WellnessTermDate,    
g20.BenefitSystemCode NutritionBenSys,g20.BenEffDate NutritionEffDate,g20.BenTermDate NutritionTermDate,    
g24.BenefitSystemCode PlusBenSys,g24.BenEffDate PlusEffDate,g24.BenTermDate PlusTermDate,    
g25.BenefitSystemCode Dental260BenSys,g25.BenEffDate Dental260EffDate,g25.BenTermDate Dental260TermDate,    
g26.BenefitSystemCode Dental466BenSys,g26.BenEffDate Dental466EffDate,g26.BenTermDate Dental466TermDate,    
g27.BenefitSystemCode Dental467BenSys,g27.BenEffDate Dental467EffDate,g27.BenTermDate Dental467TermDate,    
g28.BenefitSystemCode Dental469BenSys,g28.BenEffDate Dental469EffDate,g28.BenTermDate Dental469TermDate,    
g29.BenefitSystemCode DentalGoldBenSys,g29.BenEffDate DentalGoldEffDate,g29.BenTermDate DentalGoldTermDate,    
g30.BenefitSystemCode DentalSilverBenSys,g30.BenEffDate DentalSilverEffDate,g30.BenTermDate DentalSilverTermDate,    
g31.BenefitSystemCode HighOptionDentalBenSys,g31.BenEffDate HighOptionDentalEffDate,g31.BenTermDate HighOptionDentalTermDate,    
g32.BenefitSystemCode OptionalDentalBenSys,g32.BenEffDate OptionalDentalEffDate,g32.BenTermDate OptionalDentalTermDate,    
g38.BenefitSystemCode DentalPlatinumBenSys,g38.BenEffDate DentalPlatinumEffDate,g38.BenTermDate DentalPlatinumTermDate,    
User as CreateBy,    
Getdate() as CreateDate    
    
From #GroupBenSys g    
Left Join #GroupBenSys g1    
On g.GroupID = g1.GroupID and g1.BenefitTypeID = 1 --and g.beneffdate = g1.beneffdate -- g.RowID = g1.RowID and g1.BenefitTypeID = 1    
Left Join #GroupBenSys g4    
On g.GroupID = g4.GroupID and g4.BenefitTypeID = 4 --and g.beneffdate = g4.beneffdate -- g.RowID = g4.RowID and g4.BenefitTypeID = 4    
Left Join #GroupBenSys g6    
On g.GroupID = g6.GroupID and g6.BenefitTypeID = 6 --and g.beneffdate = g6.beneffdate -- g.RowID = g6.RowID and g6.BenefitTypeID = 6    
    
Left Join #GroupBenSys g2    
On g.GroupID = g2.GroupID and g2.BenefitTypeID = 2 --and g.beneffdate = g2.beneffdate -- g.RowID = g2.RowID and g2.BenefitTypeID = 2    
Left Join #GroupBenSys g3    
On g.GroupID = g3.GroupID and g3.BenefitTypeID = 3 --and g.beneffdate = g3.beneffdate -- g.RowID = g3.RowID and g3.BenefitTypeID = 3    
Left Join #GroupBenSys g5    
On g.GroupID = g5.GroupID and g5.BenefitTypeID = 5 --and g.beneffdate = g5.beneffdate -- g.RowID = g5.RowID and g5.BenefitTypeID = 5    
    
Left Join #GroupBenSys g7    
On g.GroupID = g7.GroupID and g7.BenefitTypeID = 7 --and g.beneffdate = g7.beneffdate -- g.RowID = g7.RowID and g7.BenefitTypeID = 7    
Left Join #GroupBenSys g8    
On g.GroupID = g8.GroupID and g8.BenefitTypeID = 8 --and g.beneffdate = g8.beneffdate -- g.RowID = g8.RowID and g8.BenefitTypeID = 8    
Left Join #GroupBenSys g9    
On g.GroupID = g9.GroupID and g9.BenefitTypeID = 9 --and g.beneffdate = g9.beneffdate -- g.RowID = g9.RowID and g9.BenefitTypeID = 9    
    
Left Join #GroupBenSys g10    
On g.GroupID = g10.GroupID and g10.BenefitTypeID = 10 --and g.beneffdate = g10.beneffdate -- g.RowID = g10.RowID and g10.BenefitTypeID = 10    
Left Join #GroupBenSys g11    
On g.GroupID = g11.GroupID and g11.BenefitTypeID = 11 --and g.beneffdate = g11.beneffdate -- g.RowID = g11.RowID and g11.BenefitTypeID = 11    
Left Join #GroupBenSys g12    
On g.GroupID = g12.GroupID and g12.BenefitTypeID = 12 --and g.beneffdate = g12.beneffdate -- g.RowID = g12.RowID and g12.BenefitTypeID = 12    
    
Left Join #GroupBenSys g13    
On g.GroupID = g13.GroupID and g13.BenefitTypeID = 13 --and g.beneffdate = g13.beneffdate -- g.RowID = g13.RowID and g13.BenefitTypeID = 13    
Left Join #GroupBenSys g14    
On g.GroupID = g14.GroupID and g14.BenefitTypeID = 14 --and g.beneffdate = g14.beneffdate -- g.RowID = g14.RowID and g14.BenefitTypeID = 14    
Left Join #GroupBenSys g15    
On g.GroupID = g15.GroupID and g15.BenefitTypeID = 15 --and g.beneffdate = g15.beneffdate -- g.RowID = g15.RowID and g15.BenefitTypeID = 15    
    
Left Join #GroupBenSys g16    
On g.GroupID = g16.GroupID and g16.BenefitTypeID = 16 --and g.beneffdate = g16.beneffdate -- g.RowID = g16.RowID and g16.BenefitTypeID = 16    
Left Join #GroupBenSys g17    
On g.GroupID = g17.GroupID and g17.BenefitTypeID = 17 --and g.beneffdate = g17.beneffdate -- g.RowID = g17.RowID and g17.BenefitTypeID = 17    
Left Join #GroupBenSys g18    
On g.GroupID = g18.GroupID and g18.BenefitTypeID = 18 --and g.beneffdate = g18.beneffdate -- g.RowID = g18.RowID and g18.BenefitTypeID = 18    
Left Join #GroupBenSys g19    
On g.GroupID = g19.GroupID and g19.BenefitTypeID = 19 --and g.beneffdate = g19.beneffdate -- g.RowID = g19.RowID and g19.BenefitTypeID = 19    
Left Join #GroupBenSys g20    
On g.GroupID = g20.GroupID and g20.BenefitTypeID = 20 --and g.beneffdate = g20.beneffdate -- g.RowID = g20.RowID and g20.BenefitTypeID = 20    
Left Join #GroupBenSys g24    
On g.GroupID = g24.GroupID and g24.BenefitTypeID = 24 --and g.beneffdate = g24.beneffdate -- g.RowID = g24.RowID and g24.BenefitTypeID = 24    
Left Join #GroupBenSys g25    
On g.GroupID = g25.GroupID and g25.BenefitTypeID = 25 --and g.beneffdate = g25.beneffdate -- g.RowID = g25.RowID and g25.BenefitTypeID = 25    
Left Join #GroupBenSys g26    
On g.GroupID = g26.GroupID and g26.BenefitTypeID = 26 --and g.beneffdate = g26.beneffdate -- g.RowID = g26.RowID and g26.BenefitTypeID = 26    
Left Join #GroupBenSys g27    
On g.GroupID = g27.GroupID and g27.BenefitTypeID = 27 --and g.beneffdate = g27.beneffdate -- g.RowID = g27.RowID and g27.BenefitTypeID = 27    
Left Join #GroupBenSys g28    
On g.GroupID = g28.GroupID and g28.BenefitTypeID = 28 --and g.beneffdate = g28.beneffdate -- g.RowID = g28.RowID and g28.BenefitTypeID = 28    
Left Join #GroupBenSys g29    
On g.GroupID = g29.GroupID and g29.BenefitTypeID = 29 --and g.beneffdate = g29.beneffdate -- g.RowID = g29.RowID and g29.BenefitTypeID = 29    
Left Join #GroupBenSys g30    
On g.GroupID = g30.GroupID and g30.BenefitTypeID = 30 --and g.beneffdate = g30.beneffdate -- g.RowID = g30.RowID and g30.BenefitTypeID = 30    
Left Join #GroupBenSys g31    
On g.GroupID = g31.GroupID and g31.BenefitTypeID = 31 --and g.beneffdate = g31.beneffdate -- g.RowID = g31.RowID and g31.BenefitTypeID = 31    
Left Join #GroupBenSys g32    
On g.GroupID = g32.GroupID and g32.BenefitTypeID = 32 --and g.beneffdate = g32.beneffdate -- g.RowID = g32.RowID and g32.BenefitTypeID = 32    
Left Join #GroupBenSys g38    
On g.GroupID = g38.GroupID and g38.BenefitTypeID = 38 --and g.beneffdate = g38.beneffdate -- g.RowID = g38.RowID and g38.BenefitTypeID = 38    
    
    
--Where g.GroupID = 1652    
order by --g.RowID,    
g.GroupID,g.GroupNumber,g.GroupEffDate    
    
    
Drop Table #GroupBenSys  