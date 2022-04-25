-- Logic for PharmacyContract Values like RxBin,RxPCN,RxGroup    
-- Siva Chavva:11/17/2009:Included CreateBy,CreateDate in table    
-- Jatin: 03/12/2019 :Changed Drop to DELETE and insert into statement for Atuitty Requirement  
  
CREATE Proc dbo.RPT_iPharmacyContract    
As    
    
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].Temp_PharmacyContract') AND type in (N'U'))    
DELETE FROM [dbo].Temp_PharmacyContract   
   
    
Insert Into dbo.Temp_PharmacyContract (SourceSystemID,BusinessSegmentID,ContractNumber,RxBin,RxPcn,RxGroup,CreateBy,CreateDate)  
  
Select Distinct    
SourceSystemID,    
BusinessSegmentID,    
ContractNumber,    
RxBin,    
RxPcn,    
RxGroup,    
User as CreateBy,    
Getdate() as CreateDate    
    
From PharmacyContract where contractnumber <> 'ALL'    
    
DECLARE @sourcesystemid int     
DECLARE @businesssegmentid int     
DECLARE @contractnumber varchar(5)    
DECLARE  @rxbin varchar(8)    
DECLARE @rxpcn varchar(8)    
DECLARE @rxgroup varchar(8)    
    
DECLARE @PcntCursor CURSOR    
    
SET ROWCOUNT 0    
SET @PcntCursor = CURSOR FAST_FORWARD    
FOR    
select distinct    
SourceSystemID,    
pc.BusinessSegmentID,    
ContractNumber,    
RxBin,    
RxPcn,    
RxGroup    
    
from PharmacyContract pc    
    
where pc.contractnumber = 'ALL'     
    
    
    
OPEN @PcntCursor    
FETCH NEXT FROM @PcntCursor    
INTO    
        @sourcesystemid,    
        @businesssegmentid,    
        @contractnumber,    
        @rxbin,    
  @rxpcn,    
  @rxgroup    
    
WHILE @@FETCH_STATUS = 0    
BEGIN    
    
insert into dbo.Temp_PharmacyContract    
select distinct    
@sourcesystemid,    
@businesssegmentid,    
c.contractnumber,    
@rxbin,    
@rxpcn,    
@rxgroup,    
User as CreateBy,    
Getdate() as CreateDate    
    
    
from  [plan] p      
inner join [contract] c on c.contractid = p.contractid    
where c.contractnumber not  in (select contractnumber from PharmacyContract pc where contractnumber <> 'ALL'    
        and pc.businesssegmentid = @businesssegmentid    
        and pc.sourcesystemid = @sourcesystemid )    
and p.businesssegmentid = @businesssegmentid    
    
FETCH NEXT FROM @PcntCursor    
  INTO    
       @sourcesystemid,    
        @businesssegmentid,    
        @contractnumber,    
        @rxbin,    
  @rxpcn,    
  @rxgroup    
END    
    
    