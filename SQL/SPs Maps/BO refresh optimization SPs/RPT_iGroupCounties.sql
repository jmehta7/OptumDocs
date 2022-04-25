CREATE Proc [dbo].[RPT_iGroupCounties]      
AS      
-----Extract Table      
-- Abhay Prakash : 08/10/2016 : Optimization - Limiting to 3 years processing     
    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupCounties]') AND type in (N'U'))      
DELETE FROM TGC --Limit processing to 3 years only    
FROM [dbo].[Temp_GroupCounties] TGC     
INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = TGC.GroupId     
 WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())         
      
insert into [dbo].[Temp_GroupCounties]      
select *  from dbo.udfGroupCounty()       
  
      
      
----RPT Table      
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupCountiesRPT]') AND type in (N'U'))      
DELETE FROM TGCR --Limit processing to 3 years only    
FROM [dbo].[Temp_GroupCountiesRPT] TGCR     
INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = TGCR.GroupId     
 WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())        
      
insert into [dbo].[Temp_GroupCountiesRPT]      
select *  from dbo.udfGroupCountyRPT()       
            
      
      
----RPTSGE Table      
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupCountiesRPTSGE]') AND type in (N'U'))      
DELETE FROM TGCS --Limit processing to 3 years only    
FROM [dbo].[Temp_GroupCountiesRPTSGE] TGCS     
INNER JOIN [Group] GP WITH(NOLOCK) ON  GP.GroupId = TGCS.GroupId     
 WHERE GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')     
 AND YEAR(GP.EffectiveDate) IN (SELECT [Years] FROM [dbo].[udfGetPrevCurrNextYears]())        
      
insert into [dbo].[Temp_GroupCountiesRPTSGE]      
select *  from dbo.udfGroupCountyRPT_SGE()       
            
   