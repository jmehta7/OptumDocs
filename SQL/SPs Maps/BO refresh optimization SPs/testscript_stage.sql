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


 
Select  BenefitID
from Temp_HospitalCopay_IDCardElements order by 1 desc
EXCEPT
 Select BenefitID
from Temp_HospitalCopay_IDCardElements_before

 -----------------------------------------------------------------------------------------------------------
 
Select Count(*) from Temp_HospitalCopay
 Select Count(*) from Temp_HospitalCopay_before

 
Select BenefitID
 from Temp_HospitalCopay order by 1 desc
 EXCEPT
 Select BenefitID
 from Temp_HospitalCopay_before


 
 -----------------------------------------------------------------------------------------------
 
 Select Count(*) from Temp_GroupPolicies
 Select Count(*) from Temp_GroupPolicies_before
 

 Select 
 GroupID
from Temp_GroupPolicies

EXCEPT 

Select 
GroupID
from 
Temp_GroupPolicies_before

----------------------------------------------------------------------------------------

 Select Count(*) from Temp_GroupBenSys
 Select Count(*) from Temp_GroupBenSys_before

 Select 
GroupID
	   EXCEPT
Select 
GroupID


---------------------------------------------------------------------------------------- 
 Select Count(*) from Temp_GroupBenefit
 Select Count(*) from Temp_GroupBenefit_before


 Select 
,CreateBy
--,CreateDate
--,Temp_GroupBenefitID

from Temp_GroupBenefit_before
EXCEPT 

Select 
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