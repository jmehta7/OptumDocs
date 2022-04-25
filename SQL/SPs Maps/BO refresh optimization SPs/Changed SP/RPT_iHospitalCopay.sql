/* Modified Date      : 10/28/2015          
   * Modified By    : Maddipati Divya         
   * Jatin 6/3/2019 : Changed DROP command to DELETE , dropped clustered index     
   *  and make it non cluster, added identity column and make it primary key, added insert into statement 
   */    
   -- Jatin Mehta : 05/20/2019 : To restrict the data processing for table dbo.PharmacyContract for three years i.e current +- 1  
   
CREATE Proc [dbo].[RPT_iHospitalCopay]        
AS        

  SELECT [IGPlan].GroupID,[IGPlan].PlanID,ipb.BenefitId 
  into #Temp_HospitalCopay
  FROM [IndividualGroupPlan] [IGPlan] WITH(NOLOCK)         
  LEFT JOIN IndividualPlanBenefit ipb WITH(NOLOCK) ON  [IGPlan].PlanId = ipb.PlanID        
  UNION        
  SELECT  GroupID,PlanID,BenefitId FROM [EmployerGroupPlanBenefit] [EGPlan] WITH(NOLOCK)        
             
--Extract Table        
--Limit data processing
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_HospitalCopay]') AND type in (N'U'))    
     DELETE FROM [dbo].[Temp_HospitalCopay]    
	 Where BenefitID IN (
	 Select BenefitID from #Temp_HospitalCopay thc  inner join [Group] gp ON thc.GroupID = gp.GroupID
	 WHERE  gp.EffectiveDate <> IsNull(gp.TerminationDate,'9999-12-31')
	 and YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()))

Insert INTO [dbo].[Temp_HospitalCopay]     (BenefitID  
         ,InpatientHospitalCopay  
         ,PhysicianCopay  
         ,SpecialistCopay  
         ,EmergencyCopay  
         ,PhysicianCoinsurance  
         ,SpecialistCoinsurance  
         ,EmergencyCoinsurance  
         ,CreateBy  
         ,CreateDate)      

 SELECT DISTINCT         
  b1.BenefitID,        
  [dbo].InpatientHospitalCopay(bd3.BenefitID,bdc3.BenefitDetailTypeID) AS [InpatientHospitalCopay],        
    
        
   CASE          
       
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount = bdt1_Tier2.CoPayMaxAmount     
     AND bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount AND bd1.CopayMinAmount IS NOT NULL     
     AND bd1.CopayMaxAmount IS NOT NULL    
      
  THEN  (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)   + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + Cast(bd1.CopayMaxAmount as     varchar))     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL     
     and bd1.CopayMaxAmount IS NOT NULL    
         
     THEN  (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)   + ' ' + '-' + ' '+ CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount   as varchar) + ' ' + '-' + ' ' 
+ Cast(bd1.CopayMaxAmount as varchar))        
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount = bdt1_Tier2.CoPayMaxAmount and bdt1_Tier1.CoPayMinAmount <>     
  bdt1_Tier1.CoPayMaxAmount AND     
  bd1.CopayMinAmount <> bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL and bd1.CopayMaxAmount IS NOT NULL    
     THEN      
    
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '-' + ' '+ CAST(bdt1_Tier1.CoPayMaxAmount as varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.CopayMinAmount as    varchar) + ' ' + '-' + ' ' + Cast(bd1.CopayMaxAmount as varchar))       
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount <> bdt1_Tier1.CoPayMaxAmount     
     AND  bd1.CopayMinAmount <> bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL     
     AND bd1.CopayMaxAmount IS NOT NULL    
     THEN      
  (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '-' + ' '+ CAST(bdt1_Tier1.CoPayMaxAmount as varchar)  + ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.CopayMinAmount as varchar) + ' ' + '-' + ' ' + Cast(bd1.CopayMaxAmount as varchar))     
    
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount = bdt1_Tier2.CoPayMaxAmount     
     AND bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount = bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL    
     THEN       
   (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar))         
      
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount and bdt1_Tier1.CoPayMinAmount <>     
  bdt1_Tier1.CoPayMaxAmount AND bd1.CopayMinAmount = bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL    
     THEN       
  (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+' '+ '-' + ' '+CAST(bdt1_Tier1.CopayMaxAmount as varchar) +  ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar))     
    
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount = bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar))         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount = bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount <> bdt1_Tier1.CoPayMaxAmount     
 AND bd1.CopayMinAmount = bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' ' + '-' + ' '+ CAST(bdt1_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar))          
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount = bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount <> bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL     
     AND bd2.CopayMaxAmount is not null    
     THEN       
  (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' ' + '-' + ' '+ CAST(bdt1_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd1.CopayMaxAmount as varchar))           
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount     
     and bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL and bd1.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd1.CopayMaxAmount as varchar))     
     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoPayMinAmount is not null and bdt1_tier1.CoPayMinAmount is not null     
     AND bdt1_Tier2.CoPayMinAmount <> bdt1_Tier2.CoPayMaxAmount and bdt1_Tier1.CoPayMinAmount <>     
    bdt1_Tier1.CoPayMaxAmount AND     
    bd1.CopayMinAmount <> bd1.CopayMaxAmount and bd1.CopayMinAmount IS NOT NULL and bd1.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd1.CopayMaxAmount as varchar))     
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoPayMinAmount is not null     
     AND bdt1_Tier1.CoPayMinAmount <> bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL and bd1.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd1.CopayMaxAmount as varchar))     
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoPayMinAmount is not null     
     AND bdt1_Tier1.CoPayMinAmount <> bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount = bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.copayMinamount as varchar))          
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoPayMinAmount is not null     
     AND bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.copayMinamount as varchar)     
 + ' ' + '-' + ' '+ CAST(bd1.CopayMaxAmount as varchar))      
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoPayMinAmount is not null     
     AND bdt1_Tier1.CoPayMinAmount = bdt1_Tier1.CoPayMaxAmount     
     AND bd1.CopayMinAmount = bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.copayMinamount as varchar))      
     
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NULL     
     AND bd1.CopayMinAmount = bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL    
     THEN       
 CAST(bd1.copayMinamount as varchar)    
     
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NULL     
     AND bd1.CopayMinAmount <> bd1.CopayMaxAmount     
     AND bd1.CopayMinAmount IS NOT NULL AND bd1.CopayMaxAmount is not null    
     THEN       
 (CAST(bd1.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd1.copayMaxAmount as varchar))    
     
  else null    
  end as  [PhysicianCopay],    
    
    
   CASE          
       
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount = bdt2_Tier2.CoPayMaxAmount     
     AND bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount AND bd2.CopayMinAmount IS NOT NULL     
     AND bd2.CopayMaxAmount IS NOT NULL    
      
  THEN  (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)   + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + Cast(bd2.CopayMaxAmount as     varchar))          
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL     
     and bd2.CopayMaxAmount IS NOT NULL    
         
     THEN  (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)   + ' ' + '-' + ' '+ CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount   as varchar) + ' ' + '-' + ' ' + Cast(bd2.CopayMaxAmount as varchar))     
     
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount = bdt2_Tier2.CoPayMaxAmount and bdt2_Tier1.CoPayMinAmount <>     
  bdt2_Tier1.CoPayMaxAmount AND     
  bd2.CopayMinAmount <> bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL and bd2.CopayMaxAmount IS NOT NULL    
     THEN      
    
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '-' + ' '+ CAST(bdt2_Tier1.CoPayMaxAmount as varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.CopayMinAmount as    varchar) + ' ' + '-' + ' ' + Cast(bd2.CopayMaxAmount as varchar))     
    
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount <> bdt2_Tier1.CoPayMaxAmount     
     AND  bd2.CopayMinAmount <> bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL     
     AND bd2.CopayMaxAmount IS NOT NULL    
     THEN      
  (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '-' + ' '+ CAST(bdt2_Tier1.CoPayMaxAmount as varchar)  + ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST
  
(bd2.CopayMinAmount as varchar) + ' ' + '-' + ' ' + Cast(bd2.CopayMaxAmount as varchar))     
    
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount = bdt2_Tier2.CoPayMaxAmount     
     AND bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount = bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL    
     THEN       
   (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar))     
    
      
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount and bdt2_Tier1.CoPayMinAmount <>     
  bdt2_Tier1.CoPayMaxAmount AND bd2.CopayMinAmount = bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL    
     THEN       
  (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+' '+ '-' + ' '+CAST(bdt2_Tier1.CopayMaxAmount as varchar) +    ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar))     
    
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount = bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar))     
    
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount = bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount <> bdt2_Tier1.CoPayMaxAmount     
 AND bd2.CopayMinAmount = bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' ' + '-' + ' '+ CAST(bdt2_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar))     
     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount = bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount <> bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL     
     AND bd2.CopayMaxAmount is not null    
     THEN       
  (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' ' + '-' + ' '+ CAST(bdt2_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd2.CopayMaxAmount as varchar))     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount     
     and bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL and bd2.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd2.CopayMaxAmount as varchar))     
     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoPayMinAmount is not null and bdt2_tier1.CoPayMinAmount is not null     
     AND bdt2_Tier2.CoPayMinAmount <> bdt2_Tier2.CoPayMaxAmount and bdt2_Tier1.CoPayMinAmount <>     
    bdt2_Tier1.CoPayMaxAmount AND     
    bd2.CopayMinAmount <> bd2.CopayMaxAmount and bd2.CopayMinAmount IS NOT NULL and bd2.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CopayMinAmount as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoPayMaxAmount as varchar) + ' ' + '/' + ' ' + CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd2.CopayMaxAmount as varchar))     
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoPayMinAmount is not null     
     AND bdt2_Tier1.CoPayMinAmount <> bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL and bd2.CopayMaxAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd2.CopayMaxAmount as varchar))     
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoPayMinAmount is not null     
     AND bdt2_Tier1.CoPayMinAmount <> bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount = bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoPayMaxAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.copayMinamount as varchar))      
    
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoPayMinAmount is not null     
     AND bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.copayMinamount as varchar)     
 + ' ' + '-' + ' '+ CAST(bd2.CopayMaxAmount as varchar))      
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoPayMinAmount is not null     
     AND bdt2_Tier1.CoPayMinAmount = bdt2_Tier1.CoPayMaxAmount     
     AND bd2.CopayMinAmount = bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoPayMinAmount AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.copayMinamount as varchar))      
     
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NULL     
     AND bd2.CopayMinAmount = bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL    
     THEN       
 CAST(bd2.copayMinamount as varchar)    
     
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NULL     
     AND bd2.CopayMinAmount <> bd2.CopayMaxAmount     
     AND bd2.CopayMinAmount IS NOT NULL AND bd2.CopayMaxAmount is not null    
     THEN       
 (CAST(bd2.copayMinamount as varchar) + ' ' + '-' + ' ' + CAST(bd2.copayMaxAmount as varchar))    
     
  else null         
    
   END AS [SpecialistCopay], -- As per TT 127884, CC 1.1           
            
   CASE          
    WHEN [bd7].[CopayMinAmount] >= 0.00 and IsNull([bd7].[CoInsuranceMinPercent],0.00) = 0.00           
     THEN Cast([bd7].[CopayMinAmount]  AS VARCHAR)          
    WHEN [bd7].[CopayMinAmount] > 0.00 and [bd7].[CoInsuranceMinPercent] > 0.00          
     THEN Cast([bd7].[CopayMinAmount]  AS VARCHAR)          
    ELSE NULL          
   END AS [EmergencyCopay], -- As per TT 127884, CC 1.1           
         
         
         
   CASE          
       
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent = bdt1_Tier2.CoInsMaxPercent     
     AND bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent AND bd1.CoInsuranceMinPercent IS NOT NULL     
     AND bd1.CoInsuranceMaxPercent IS NOT NULL    
      
  THEN  (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)   + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' +       Cast(bd1.CoInsuranceMaxPercent as varchar))     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL     
     and bd1.CoInsuranceMaxPercent IS NOT NULL    
         
     THEN  (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)   + ' ' + '-' + ' '+ CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' +          CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + Cast(bd1.CoInsuranceMaxPercent as varchar))     
     
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent = bdt1_Tier2.CoInsMaxPercent and bdt1_Tier1.CoInsMinPercent <>     
  bdt1_Tier1.CoInsMaxPercent AND     
  bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL and     
  bd1.CoInsuranceMaxPercent IS NOT NULL    
     THEN      
    
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '-' + ' '+ CAST(bdt1_Tier1.CoInsMaxPercent as varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as    varchar) + ' ' + '-' + ' ' + Cast(bd1.CoInsuranceMaxPercent as varchar))     
    
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent <> bdt1_Tier1.CoInsMaxPercent     
     AND  bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL     
     AND bd1.CoInsuranceMaxPercent IS NOT NULL    
     THEN      
  (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '-' + ' '+ CAST(bdt1_Tier1.CoInsMaxPercent as varchar)  + ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar) + ' ' + '-' + ' ' +       CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + Cast(bd1.CoInsuranceMaxPercent as varchar))     
    
         
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent = bdt1_Tier2.CoInsMaxPercent     
     AND bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
   (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))     
    
      
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent and bdt1_Tier1.CoInsMinPercent <>     
  bdt1_Tier1.CoInsMaxPercent AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
  (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+' '+ '-' + ' '+CAST(bdt1_Tier1.CoInsMaxPercent as varchar) +      ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))     
    
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))     
    
     WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent = bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent <> bdt1_Tier1.CoInsMaxPercent     
 AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' ' + '-' + ' '+ CAST(bdt1_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))     
     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent = bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent <> bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL     
     AND bd1.CoInsuranceMaxPercent is not null    
     THEN       
  (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' ' + '-' + ' '+ CAST(bdt1_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd1.CoInsuranceMaxPercent as varchar))     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent     
     and bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL and bd1.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd1.CoInsuranceMaxPercent as varchar))     
     
      
  WHEN bdt1_Tier2.TierID IS NOT NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND bdt1_Tier2.CoInsMinPercent is not null and bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier2.CoInsMinPercent <> bdt1_Tier2.CoInsMaxPercent and bdt1_Tier1.CoInsMinPercent <>     
    bdt1_Tier1.CoInsMaxPercent AND     
    bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent and bd1.CoInsuranceMinPercent IS NOT NULL and bd1.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoInsMaxPercent AS varchar)+      ' '+ '/' + ' ' +CAST(bdt1_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt1_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd1.CoInsuranceMaxPercent as varchar))     
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier1.CoInsMinPercent <> bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL and bd1.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd1.CoInsuranceMaxPercent as varchar))     
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier1.CoInsMinPercent <> bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt1_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))      
    
    
  WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar)     
 + ' ' + '-' + ' '+ CAST(bd1.CoInsuranceMaxPercent as varchar))      
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NOT NULL     
     AND  bdt1_Tier1.CoInsMinPercent is not null     
     AND bdt1_Tier1.CoInsMinPercent = bdt1_Tier1.CoInsMaxPercent     
     AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt1_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd1.CoInsuranceMinPercent as varchar))      
     
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NULL     
     AND bd1.CoInsuranceMinPercent = bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 CAST(bd1.CoInsuranceMinPercent as varchar)    
     
     
     WHEN bdt1_Tier2.TierID IS NULL AND bdt1_Tier1.TierID IS NULL     
     AND bd1.CoInsuranceMinPercent <> bd1.CoInsuranceMaxPercent     
     AND bd1.CoInsuranceMinPercent IS NOT NULL AND bd1.CoInsuranceMaxPercent is not null    
     THEN       
 (CAST(bd1.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd1.CoInsuranceMaxPercent as varchar))    
     
  else null    
   END AS [PhysicianCoinsurance], -- Included Coinsurance as per TT 127884 CC 1.1           
            
        
   CASE          
       
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent = bdt2_Tier2.CoInsMaxPercent     
     AND bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent AND bd2.CoInsuranceMinPercent IS NOT NULL     
     AND bd2.CoInsuranceMaxPercent IS NOT NULL    
      
  THEN  (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)   + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' +       Cast(bd2.CoInsuranceMaxPercent as varchar))     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL     
     and bd2.CoInsuranceMaxPercent IS NOT NULL    
         
     THEN  (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)   + ' ' + '-' + ' '+ CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' +          CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + Cast(bd2.CoInsuranceMaxPercent as varchar))     
     
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent = bdt2_Tier2.CoInsMaxPercent and bdt2_Tier1.CoInsMinPercent <>     
  bdt2_Tier1.CoInsMaxPercent AND     
  bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL and     
  bd2.CoInsuranceMaxPercent IS NOT NULL    
     THEN      
    
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '-' + ' '+ CAST(bdt2_Tier1.CoInsMaxPercent as varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as    varchar) + ' ' + '-' + ' ' + Cast(bd2.CoInsuranceMaxPercent as varchar))     
    
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent <> bdt2_Tier1.CoInsMaxPercent     
     AND  bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL     
     AND bd2.CoInsuranceMaxPercent IS NOT NULL    
     THEN      
  (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '-' + ' '+ CAST(bdt2_Tier1.CoInsMaxPercent as varchar)  + ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar) + ' ' + '-' + ' ' +      CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + Cast(bd2.CoInsuranceMaxPercent as varchar))     
    
         
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent = bdt2_Tier2.CoInsMaxPercent     
     AND bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
   (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))     
    
      
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent and bdt2_Tier1.CoInsMinPercent <>     
  bdt2_Tier1.CoInsMaxPercent AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
  (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+' '+ '-' + ' '+CAST(bdt2_Tier1.CoInsMaxPercent as varchar) +    
  ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))     
    
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))     
    
     WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent = bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent <> bdt2_Tier1.CoInsMaxPercent     
 AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' ' + '-' + ' '+ CAST(bdt2_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))     
     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent = bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent <> bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL     
     AND bd2.CoInsuranceMaxPercent is not null    
     THEN       
  (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' ' + '-' + ' '+ CAST(bdt2_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd2.CoInsuranceMaxPercent as varchar))     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent     
     and bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL and bd2.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd2.CoInsuranceMaxPercent as varchar))     
     
      
  WHEN bdt2_Tier2.TierID IS NOT NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND bdt2_Tier2.CoInsMinPercent is not null and bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier2.CoInsMinPercent <> bdt2_Tier2.CoInsMaxPercent and bdt2_Tier1.CoInsMinPercent <>     
    bdt2_Tier1.CoInsMaxPercent AND     
    bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent and bd2.CoInsuranceMinPercent IS NOT NULL and bd2.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoInsMaxPercent AS varchar)+     
 ' '+ '/' + ' ' +CAST(bdt2_Tier2.CoInsMinPercent as varchar)+' ' + '-' + ' ' + CAST(bdt2_Tier2.CoInsMaxPercent as varchar) + ' ' + '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd2.CoInsuranceMaxPercent as varchar))     
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier1.CoInsMinPercent <> bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL and bd2.CoInsuranceMaxPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd2.CoInsuranceMaxPercent as varchar))     
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier1.CoInsMinPercent <> bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar) + ' ' + '-' + ' ' + CAST(bdt2_Tier1.CoInsMaxPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))      
    
    
  WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar)     
 + ' ' + '-' + ' '+ CAST(bd2.CoInsuranceMaxPercent as varchar))      
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NOT NULL     
     AND  bdt2_Tier1.CoInsMinPercent is not null     
     AND bdt2_Tier1.CoInsMinPercent = bdt2_Tier1.CoInsMaxPercent     
     AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL         THEN       
 (Cast(bdt2_Tier1.CoInsMinPercent AS varchar)+ ' '+ '/' + ' ' + CAST(bd2.CoInsuranceMinPercent as varchar))      
     
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NULL     
     AND bd2.CoInsuranceMinPercent = bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL    
     THEN       
 CAST(bd2.CoInsuranceMinPercent as varchar)    
     
     
     WHEN bdt2_Tier2.TierID IS NULL AND bdt2_Tier1.TierID IS NULL     
     AND bd2.CoInsuranceMinPercent <> bd2.CoInsuranceMaxPercent     
     AND bd2.CoInsuranceMinPercent IS NOT NULL AND bd2.CoInsuranceMaxPercent is not null    
     THEN       
 (CAST(bd2.CoInsuranceMinPercent as varchar) + ' ' + '-' + ' ' + CAST(bd2.CoInsuranceMaxPercent as varchar))    
     
  else null          
   END AS [SpecialistCoinsurance], -- Included Coinsurance as per TT 127884 CC 1.1           
            
        
   CASE          
    WHEN [bd7].[CoInsuranceMinPercent] > 0.00 and IsNull([bd7].[CopayMinAmount],0.00) = 0.00           
     THEN RTrim(LTrim(Cast([bd7].[CoInsuranceMinPercent]  AS VARCHAR)))          
    WHEN [bd7].[CoInsuranceMinPercent] = 0.00 and [bd7].[CopayMinAmount] IS NULL          
     THEN RTrim(LTrim(Cast([bd7].[CoInsuranceMinPercent]  AS VARCHAR)))          
    WHEN [bd7].[CoInsuranceMinPercent] > 0.00 and [bd7].[CopayMinAmount] > 0.00          
     THEN RTrim(LTrim(Cast([bd7].[CoInsuranceMinPercent]  AS VARCHAR)))          
    ELSE NULL          
   END AS [EmergencyCoinsurance], -- Included Coinsurance as per TT 127884 CC 1.1           
        
  User as CreateBy,        
  Getdate() as CreateDate        
          
        FROM  [Contract] [CNT] WITH(NOLOCK)         
        INNER JOIN [Plan] [P] WITH(NOLOCK)         
              ON  [CNT].[ContractID] = [P].[ContractID] AND p.IsActive = 1        
        INNER JOIN [BusinessSegment] [BS] WITH(NOLOCK)         
              ON  [P].[BusinessSegmentID] = [BS].[BusinessSegmentID]         
        INNER JOIN [PlanType] [PT] WITH(NOLOCK)         
              ON  [P].[PlanTypeID] = [PT].[PlanTypeID]                     
        --INNER JOIN (SELECT [IGPlan].GroupID,[IGPlan].PlanID,ipb.BenefitId FROM [IndividualGroupPlan] [IGPlan] WITH(NOLOCK)         
        --             LEFT JOIN IndividualPlanBenefit ipb WITH(NOLOCK) ON  [IGPlan].PlanId = ipb.PlanID        
        --             UNION        
        --      SELECT  GroupID,PlanID,BenefitId FROM [EmployerGroupPlanBenefit] [EGPlan] WITH(NOLOCK)        
        --    )[GPlan]  
		 INNER JOIN (SELECT GroupID,PlanID,BenefitId FROM #Temp_HospitalCopay [IGPlan]  
        )[GPlan]          
       ON  [GPlan].[PlanID] = [P].[PlanID]        
        INNER JOIN [GROUP] [GP] WITH(NOLOCK)         
              ON  [GP].[GroupID] = [GPlan].[GroupID]        
      INNER JOIN [MasterGroup] [MGP] WITH(NOLOCK)        
       ON  [MGP].[MasterGroupID] = [GP].[MasterGroupID]        
        INNER JOIN [Division] [DV] WITH(NOLOCK)         
              ON  [DV].DivisionID = [GP].DivisionID        
        INNER JOIN [SourceSystem] [SS] WITH(NOLOCK)        
              ON  [DV].[SourceSystemID] = [SS].[SourceSystemID]        
   INNER JOIN [GROUPType] [GT] WITH(NOLOCK)         
              ON  [GT].[GroupTypeID] = [GP].[GroupTypeID]        
                
        RIGHT JOIN Benefit b1 WITH(NOLOCK)         
              ON  gplan.BenefitId = b1.BenefitId AND b1.BenefitTypeId IN (1) AND NetworkTypeID = 1            
   LEFT JOIN BenefitDetailType bdc1 WITH(NOLOCK)         
             ON  bdc1.[Name] = '7a' -- Primary Care/Exam OV        
        LEFT JOIN MedicalBenefitDetail bd1 WITH(NOLOCK)         
             ON  gplan.BenefitID = bd1.BenefitID AND bd1.BenefitDetailTypeID = bdc1.BenefitDetailTypeID         
             AND b1.BenefitTypeId IN (1)         
  LEFT JOIN MedicalBenefitDetailTier bdt1_Tier1 WITH(NOLOCK)    
             ON gplan.BenefitID = bdt1_Tier1.BenefitID AND bdt1_Tier1.BenefitDetailTypeID = bdc1.BenefitDetailTypeID    
             AND b1.BenefitTypeID = 1  and bdt1_Tier1.TierID = 1      
  LEFT JOIN MedicalBenefitDetailTier bdt1_Tier2 WITH(NOLOCK)    
        ON gplan.BenefitID = bdt1_Tier2.BenefitID AND bdt1_Tier2.BenefitDetailTypeID = bdc1.BenefitDetailTypeID    
             AND b1.BenefitTypeID = 1  and bdt1_Tier2.TierID = 2    
        LEFT JOIN BenefitDetailType bdc2 WITH(NOLOCK)         
             ON  bdc2.[Name] = '7d' -- Specialist OV        
        LEFT JOIN MedicalBenefitDetail bd2 WITH(NOLOCK)         
             ON  gplan.BenefitID = bd2.BenefitID AND bd2.BenefitDetailTypeID = bdc2.BenefitDetailTypeID         
             AND b1.BenefitTypeId IN (1)        
  LEFT JOIN MedicalBenefitDetailTier bdt2_Tier1 WITH(NOLOCK)    
             ON gplan.BenefitID = bdt2_Tier1.BenefitID AND bdt2_Tier1.BenefitDetailTypeID = bdc2.BenefitDetailTypeID    
             AND b1.BenefitTypeID = 1 and bdt2_Tier1.TierID = 1      
  LEFT JOIN MedicalBenefitDetailTier bdt2_Tier2 WITH(NOLOCK)    
             ON gplan.BenefitID = bdt2_Tier2.BenefitID AND bdt2_Tier2.BenefitDetailTypeID = bdc2.BenefitDetailTypeID    
             AND b1.BenefitTypeID = 1 and bdt2_Tier2.TierID = 2     
        LEFT JOIN BenefitDetailType bdc7 WITH(NOLOCK)         
             ON  bdc7.[Name] = '4a' -- Emergency Care        
        LEFT JOIN MedicalBenefitDetail bd7 WITH(NOLOCK)         
             ON  gplan.BenefitID = bd7.BenefitID AND bd7.BenefitDetailTypeID = bdc7.BenefitDetailTypeID         
             AND b1.BenefitTypeId IN (1)               
        LEFT JOIN BenefitDetailType bdc3 WITH(NOLOCK)         
             ON  bdc3.[Name] = '1a' -- Inpatient Hospital – Medicare Covered Stay (MCS)        
        LEFT JOIN MedicalBenefitDetail bd3 WITH(NOLOCK)         
             ON  gplan.BenefitID = bd3.BenefitID AND bd3.BenefitDetailTypeID = bdc3.BenefitDetailTypeID         
             AND b1.BenefitTypeId IN (1)        
                
        WHERE  gp.EffectiveDate <> IsNull(gp.TerminationDate,'9999-12-31')
		
		and  YEAR(gp.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())   
		
		Drop table #Temp_HospitalCopay