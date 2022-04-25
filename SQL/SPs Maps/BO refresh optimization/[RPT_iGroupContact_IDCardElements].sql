--CreatedBy :MaddipatiDivya        
--ModifiedBy    
-- Narasimha: 25/07/2018 - Updating the contact information from indvidualGroupContact if group has an exception record.    
-- Divya : 03/04/2019 - Added Segment wherever it is required    
        
     CREATE  PROC [dbo].[RPT_iGroupContact_IDCardElements]                  
AS              
      IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupContact_IDCardElements]') AND type in (N'U'))                  
      DELETE FROM TGC --Limit processing to 3 years only          
      FROM [dbo].[Temp_GroupContact_IDCardElements] TGC           
      INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = TGC.GroupId           
       WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')           
    AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())           
    
   select exceptions.*    
   INTO dbo.#GroupContactExceptions                 
      FROM     
   (Select gp.GroupID, P.PlanID,ContactTypeID, [Address1],[Address2],[City],[StateCode],[ZipCode],[PhoneNumber],[TTY],[EmailAddress],[FaxNumber],[WebSiteURL],[HoursOfOperation]  from IndividualGroupContact IGC WITH(NOLOCK)    
   INNER JOIN dbo.[plan] p WITH(NOLOCK) on p.PBPNumber=IGC.PBPNumber  and p.Segment=IGC.Segment and p.EffectiveDate = IGC.GroupEffectiveDate     
      INNER JOIN [Contract] [C] WITH(NOLOCK) ON  [C].[ContractNumber] = [IGC].[ContractNumber]           
   INNER JOIN dbo.[group] gp WITH(NOLOCK) on gp.groupNumber = IGC.groupNumber   and gp.EffectiveDate = IGC.GroupEffectiveDate             
      INNER JOIN [MasterGroup] [MGP] WITH(NOLOCK) ON  [gp].[MasterGroupID]  = [MGP].[MasterGroupID] and MGP.[MasterGroupNumber] = iGC.[MasterGroupNumber]    
      INNER JOIN [Division] [DV] WITH(NOLOCK) ON  [DV].DivisionID = [gp].DivisionID and [DV].DivisionID = iGC.DivisionID    
   where IGC.ContactTypeID in (1,2,5,6,8,9,35)) exceptions    
       
         
      SELECT contact.*                 
      INTO dbo.#PlanContactID                 
      FROM                 
      (SELECT DISTINCT igp.[GroupID], ipc.PlanID, [StateID],                
            ipc.[ContactTypeID],ISNULL(GCE.[Address1], ipc.[Address1]) AS [Address1],ISNULL(GCE.[Address2], ipc.[Address2]) AS [Address2],ISNULL (GCE.[City], ipc.[City]) AS [City],ISNULL(GCE.[StateCode], ipc.[StateCode]) AS [StateCode],ISNULL(GCE.[ZipCode
], ipc.[ZipCode]) AS [ZipCode],ISNULL(GCE.[PhoneNumber], ipc.[PhoneNumber]) AS [PhoneNumber],ISNULL(GCE.[TTY], ipc.[TTY]) AS [TTY],ISNULL(GCE.[EmailAddress], ipc.[EmailAddress]) AS [EmailAddress],ISNULL(GCE.[FaxNumber], ipc.[FaxNumber]) AS [FaxNumber],ISN
ULL(GCE.[WebSiteURL],ipc.[WebSiteURL]) AS [WebSiteURL],ISNULL(GCE.[HoursOfOperation], ipc.[HoursOfOperation]) AS [HoursOfOperation]    
      FROM [dbo].[IndividualPlanBenefit] ipb WITH(NOLOCK)                
            INNER JOIN [dbo].[IndividualPlanContact] ipc WITH(NOLOCK) ON ipb.PlanID = ipc.PlanID                
            INNER JOIN [dbo].[IndividualGroupPlan] igp WITH(NOLOCK) ON ipc.PlanID = igp.PlanID    
   LEFT OUTER JOIN #GroupContactExceptions GCE WITH(NOLOCK) ON GCE.PlanID = ipc.PlanID and GCE.GroupID = igp.GroupID and GCE.ContactTypeID = ipc.ContactTypeID    
      UNION                
      SELECT DISTINCT egc.[GroupID],egb.[PlanID],[StateID],                
            [ContactTypeID],[Address1],[Address2],[City],[StateCode],[ZipCode],[PhoneNumber],[TTY],[EmailAddress],[FaxNumber],[WebSiteURL],[HoursOfOperation]                    
      FROM [dbo].[EmployerGroupPlanBenefit] egb WITH(NOLOCK)                    
            INNER JOIN [dbo].[EmployerGroupContact] egc WITH(NOLOCK) ON  egc.GroupID = egb.GroupID                 
       ) contact                 
      INNER JOIN dbo.[plan] p WITH(NOLOCK) on p.planid=contact.planid         
      --AND p.isactive=1                
      INNER JOIN [Contract] [CNT] WITH(NOLOCK) ON  [CNT].[ContractID] = [P].[ContractID]                
      INNER JOIN [BusinessSegment] [BS] WITH(NOLOCK) ON  [P].[BusinessSegmentID] = [BS].[BusinessSegmentID]                   
      INNER JOIN [PlanType] [PT] WITH(NOLOCK) ON  [P].[PlanTypeID] = [PT].[PlanTypeID]                     
      INNER JOIN dbo.[group] gp WITH(NOLOCK) on gp.groupid=contact.groupid                
      INNER JOIN [MasterGroup] [MGP] WITH(NOLOCK) ON  [MGP].[MasterGroupID] = [GP].[MasterGroupID]                  
      INNER JOIN [Division] [DV] WITH(NOLOCK) ON  [DV].DivisionID = [GP].DivisionID                  
      INNER JOIN [SourceSystem] [SS] WITH(NOLOCK) ON  [DV].[SourceSystemID] = [SS].[SourceSystemID]                  
      INNER JOIN [GROUPType] [GT] WITH(NOLOCK) ON  [GT].[GroupTypeID] = [GP].[GroupTypeID]                
      WHERE gp.EffectiveDate <> IsNull(gp.TerminationDate,'9999-12-31')                 
      AND YEAR(gp.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())  --Limit to 3 yrs          
      AND contact.ContactTypeID in (1,2,5,6,8,9,35)  --Pull only required ContactTypes          
      ORDER BY [GroupID],[PlanID],[StateID],ContactTypeID            
                   
      --Added ContactType to index          
      CREATE NONCLUSTERED INDEX IX_PlanContactIDCardElements_ID ON  dbo.#PlanContactID(PlanID,GroupID,StateID,ContactTypeID) --568652                
                        
                  
      SELECT DISTINCT                    
         S.StateID,                    
         GC.GroupID                
         INTO dbo.#state                   
       FROM                    
       GroupCounty GC WITH(NOLOCK)                         
       INNER JOIN County Co WITH(NOLOCK) ON  Co.CountyID = GC.CountyID                     
       INNER JOIN State S WITH(NOLOCK) ON  S.StateID = Co.StateID                
       INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = GC.GroupId      --Limit to 3 yrs          
       WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')                 
    AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())           
    ORDER BY GroupID, StateID           
                       
       CREATE NONCLUSTERED INDEX IX_PlanContactIDCardElements_ID1 ON dbo.#state(groupid,stateid)                 
                
                     
      INSERT INTO [dbo].[Temp_GroupContact_IDCardElements]            
      SELECT DISTINCT p.groupid,p.planid,s.stateid,                
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=2                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
         LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=2                
         WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
   AND pc.groupid=p.groupid AND pc.planid=p.planid                
        )  AS CustomerServicePhoneNumber,                
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[TTY],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=2                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=2               
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS TTYNumber,                
      (SELECT top 1  RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] pc WITH(NOLOCK) WHERE pc.contacttypeid=35                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
         WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid AND p1.stateid=pc.stateid AND p1.contacttypeid=35)                
         AND s.stateid=isnull(pc.stateid,s.stateid)                
   AND pc.groupid=p.groupid AND pc.planid=p.planid            
        )  AS SHIPPhoneNumber,                
      (SELECT top 1 PC.Address2      
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=2                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=2                 
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS CorrespondenceAddress1,                
      (SELECT top 1  PC.[City] + ', ' + PC.[StateCode] + ' ' + PC.[ZipCode]            
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=2                
    AND EXISTS (SELECT [City] + ', ' +  [StateCode] + ' ' +[ZipCode] FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=2                 
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS CorrespondenceAddress2,                                                                                                              
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=6                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=6                 
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS MHSAPhonenumber,                
      (SELECT  top 1  RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[TTY],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=6                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                
         LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=6                  
         WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
   AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS MHSATTY,                                                                                                           
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=8                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=8                  
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS NurselinePhoneNumber,                
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[TTY],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=8                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=8                 
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid   
        )  AS NurselineTTY,                  
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=5            
   AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                
                    LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=5                 
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                 
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS DentalPhoneNumber,                 
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[TTY],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=5                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
        LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=5                
        WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS DentalTTY,                
      (SELECT top 1 RIGHT(RTrim(LTrim(Replace(Replace(Replace(PC.[PhoneNumber],CHAR(13),''),CHAR(10),''),CHAR(9),''))),14)           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=9                
    AND EXISTS (SELECT 1 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
         LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid AND p1.contacttypeid=9                
         WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid)                
   AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS ProviderServicePhoneNumber,                  
      (SELECT top 1 PC.Address2             
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=1                
    AND EXISTS (SELECT Address2 FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid                
                              WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid AND p1.contacttypeid=1)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  )  AS ClaimsAddress1,               
      (SELECT top 1 PC.[City] + ', ' +  PC.[StateCode] + ' ' + PC.[ZipCode]           
   FROM [#PlanContactID] PC WITH(NOLOCK) WHERE pc.contacttypeid=1                
    AND EXISTS (SELECT [City] + ', ' + [StateCode] + ' ' + [ZipCode] FROM [#PlanContactID] p1 WITH(NOLOCK)                 
                              LEFT JOIN #state s WITH(NOLOCK) on s.groupid=p1.groupid                
                 WHERE p1.groupid=pc.groupid AND p1.planid=pc.planid AND p1.contacttypeid=1)                
            AND pc.groupid=p.groupid AND pc.planid=p.planid                
  ) AS ClaimsAddress2,             
      User as CreateBy,                  
   Getdate() as CreateDate                                                               
      FROM [#PlanContactID] p                
      LEFT JOIN #state s on s.groupid=p.groupid                
                
       
    
      DROP TABLE dbo.#state                
      DROP TABLE dbo.#PlanContactID    
   DROP TABLE dbo.#GroupContactExceptions