-- Siva Chavva : 06/01/2009 :Commented Final Select statement      
-- Siva Chavva:11/17/2009:Included CreateBy,CreateDate in table     
-- Jatin 03/13/2019 : Removed index of dbo.Temp_GroupBenSys table , added insert into statement , change from DROP to DELETE for Attunity requirement   
-- Jatin Mehta : 05/20/2019 : To restrict the data of table dbo.Temp_GroupChangeCodes for three years i.e current +- 1  
  
ALTER Proc dbo.RPT_iGroupChangeCodes      
AS      
DECLARE @GroupID int      
      
--Step 5: Populate our GroupMoveFromList table      
      
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_GroupChangeCodes]') AND type in (N'U'))
      
Delete FROM TGC
from [dbo].[Temp_GroupChangeCodes] TGC
Inner Join [Group] GP WITH(NOLOCK) ON GP.GroupID = TGC.GroupID
where  GP.EffectiveDate <> IsNull(GP.TerminationDate,'9999-12-31')   
and YEAR(GP.EffectiveDate ) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears()) 

 
Insert into dbo.Temp_GroupChangeCodes (GroupID  
          ,GroupMoveFrom  
          ,GroupMoveFromList  
          ,DivisionMoveFrom  
          ,ChangeCode  
          ,CreateBy  
          ,CreateDate)  
  
Select      
g.GroupID as GroupID,      
       min(gmf.GroupMoveFrom) as GroupMoveFrom,             
       convert(varchar(255),'') as GroupMoveFromList,      
    min(DivisionMoveFrom) DivisionMoveFrom,      
    min(ChangeCode) ChangeCode,      
  User as CreateBy,      
  Getdate() as CreateDate      
  
from [Group] g      
     Inner join GroupChange gmf      
        on g.GroupID = gmf.GroupId 
		-- To limit three year processing
		where g.EffectiveDate <> IsNull(g.TerminationDate,'9999-12-31')   
		and YEAR(g.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())  
group by g.GroupID      
         
  
      
--Append GroupMoveFromCodes      
DECLARE @GroupMoveFromList varchar(255)      
DECLARE @GroupMoveFrom varchar(7)      
DECLARE @DivisionMoveFrom varchar(255)      
DECLARE @ChangeCode varchar(7)      
      
      
DECLARE @GMFCursor CURSOR      
      
SET ROWCOUNT 0      
SET @GMFCursor = CURSOR FAST_FORWARD      
FOR      
select gmf.GroupID,      
       gmf.GroupMoveFrom,      
    gmf.DivisionMoveFrom,      
    gmf.ChangeCode                    
from GroupChange gmf      
inner join [Group] g on g.GroupID = gmf.GroupID 
where g.EffectiveDate <> IsNull(g.TerminationDate,'9999-12-31')   
and YEAR(g.EffectiveDate) IN (SELECT Years FROM dbo.udfGetPrevCurrNextYears())
          
OPEN @GMFCursor      
FETCH NEXT FROM @GMFCursor      
INTO      
        @GroupID,      
        @GroupMoveFrom,      
  @DivisionMoveFrom,      
  @ChangeCode             
      
WHILE @@FETCH_STATUS = 0      
BEGIN      
  select @GroupMoveFromList = GroupMoveFromList      
  from Temp_GroupChangeCodes      
  where GroupID = @GroupId      
      
  if @GroupMoveFromList = ''      
  BEGIN      
    update Temp_GroupChangeCodes      
    set GroupMoveFromList = @GroupMoveFrom,      
        DivisionMoveFrom = @DivisionMoveFrom,      
      ChangeCode = @ChangeCode      
    where GroupID = @GroupID      
  END       
  ELSE      
  BEGIN      
    update Temp_GroupChangeCodes      
    set GroupMoveFromList = left(GroupMoveFromList + ',' + @GroupMoveFrom, 255)      
               
    where GroupID = @GroupID      
  END      
      
  FETCH NEXT FROM @GMFCursor      
  INTO      
        @GroupID,      
        @GroupMoveFrom,      
  @DivisionMoveFrom,      
  @ChangeCode             
      
END