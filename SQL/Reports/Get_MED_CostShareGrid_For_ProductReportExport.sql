USE [BTB]
GO
/****** Object:  StoredProcedure [CS].[Get_MED_CostShareGrid_For_ProductReportExport]    Script Date: 7/26/2021 4:05:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Vandana
-- Create date: 21/07/2021
-- Description: For ProductInfoExport Report - Med CS Details IEX product 
-- =============================================
Create proc [CS].[Get_MED_CostShareGrid_For_ProductReportExport]      
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