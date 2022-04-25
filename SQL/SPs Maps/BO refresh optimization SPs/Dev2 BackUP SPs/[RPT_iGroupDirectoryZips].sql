  
/* Jatin 6/3/2019 : Changed DROP command to DELETE , dropped clustered index     
*   and make it non cluster and added identity column and make it primary key     
*   and make it non cluster and addedidentity column and make it primary key  and added insert into statement  
*/   
CREATE Proc [dbo].[RPT_iGroupDirectoryZips]    
As    
    
DECLARE @GroupID int    
DECLARE @StateID int    
DECLARE @CMSCountyCode VARCHAR(3)    
DECLARE @CountyName VARCHAR(50)    
    
    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].Temp_GroupDirectoryZips') AND type in (N'U'))    
DELETE FROM [dbo].Temp_GroupDirectoryZips    
    
   Insert INTO [dbo].Temp_GroupDirectoryZips  (PlanID  
      ,State  
      ,County  
      ,CountyCode  
      ,ZipCodesperCounty  
      ,CreateBy  
      ,CreateDate)  
   Select PlanID,     
                   st.Name as [State],    
       co.CMSName as [County],    
                   co.CMSCode as [CountyCode],    
                   zp.ZipCodeList as [ZipCodesperCounty],    
     User as CreateBy,    
     Getdate() as CreateDate    
    
     
             FROM [PlanCounty] pc WITH(NOLOCK)     
             Inner Join [County] co WITH(NOLOCK)   on co.CountyId = pc.CountyId    
             Inner Join [State] st WITH(NOLOCK)    on co.StateId = st.StateId      
             Inner Join (    
                          select distinct                       
                          CountyId ,    
                          ZipCodeList = Replace(    
                                    ( select ZipCode as [data()]    
                                            from (    
                                                      SELECT     
                                                      Cz.CountyID,     
                                                      ZipCode     
                                                             
                                                      FROM [CountyZip] cz WITH(NOLOCK)    
                                                      INNER JOIN [Zip] zp WITH(NOLOCK) ON zp.ZipID = cz.ZipId     
                                                      ) czl1     
                                    where czl1.CountyID = CountyZipList.CountyID    
                                    for xml path ('')    
                                    ) , ' ' , ',' )    
                          from (    
                                    SELECT     
                                    Cz.CountyID,     
                                    ZipCode                          
                                    FROM [CountyZip] cz WITH(NOLOCK)    
                                    INNER JOIN [Zip] zp WITH(NOLOCK) ON zp.ZipID = cz.ZipId     
                                    )CountyZipList     
       ) zp on zp.CountyId = co.CountyId    
    
    