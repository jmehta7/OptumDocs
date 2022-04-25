use btb

sp_tables '%IEX%'

Select * from CS.GppMedCostShareRowMapping mp where RowLabel like '%Temporomandibular%'
 like 'BBNC0002 - NC BRON ValPls 3 PCP 6 VV Fr D7600/15200 O8700/17400 PC50%'

Select CSPProductID,* from CS.MemberGroupCSPProducts  where CSPProductID IN (760,762)
--Except 

order by CSPProductID asc

Select 

--Select cust.Name, mp.RwID,mp.RowLabel,CSPProductDesc,gv.* 

--Select DISTINCT gv.MemberGroupID , gv.PlanID,cs.CSPProductID,cs.CSPProductDesc
Select *
--cust.Name, mp.RwID,mp.RowLabel,CSPProductDesc,gv.*
from CS.GppMedCostShareGridValues  gv
inner join CS.MemberGroupCSPProducts cs 
ON cs.CSPProductID = gv.CSPProductID 
inner join CS.GppMedCostShareRowMapping mp
ON mp.RwID = gv.RwID
inner join CS.MemberGroups mg on mg.MemberGroupID = gv.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
where 
gv.MemberGroupID IN ( 40308,40313,40314,40315,40316,40317,40318,40319,40320,40321,40322,40323,40324,40325,40326)
--cs.CSPProductID IN( 278,705,761,213)

--mp.RwID IN( 4) 
--and
and cs.CSPProductDesc IN ('BBNC0002 - NC BRON ValPls 3 PCP 6 VV Fr D7600/15200 O8700/17400 PC50',
'BBNC0002 - NC BRON ValPls 3 PCP 6 VV Fr D7600/15200 O8700/17400 PC50',
'BBNC0003 - NC BRON-A ValPls 3 PCP 6 VV Fr AI0CS 0 CS',
'BGNC0002 - NC GOLD ValPls 3 PCP 6 VV Fr D3000/6000 O8700/17400 PC25',
'BGNC0003 - NC GOLD-A ValPls 3 PCP 6 VV Fr AI0CS 0 CS',
'BSCNC003 - NC SILV-E ValPls UNLM Fr PCP VV CSR73 D3000/6000 O6900/13800 PC30',
'BSCNC004 - NC SILV-D ValPls UNLM Fr PCP VV CSR87 D1000/2000 O2250/4500 PC20',
'BSCNC005 - NC SILV-C ValPls UNLM Fr PCP VV CSR94 D75/150 O1900/3800 PC10',
'BSCNC006 - NC SILV-E ValPlsSav 3 PCP 6 VV Fr CSR73 D2500/5000 O6800/13600 PC25',
'BSCNC007 - NC SILV-D ValPlsSav 3 PCP 6 VV Fr CSR87 D800/1600 O2500/5000 PC25',
'BSCNC008 - NC SILV-C ValPlsSav 3 PCP 6 VV Fr CSR94 D50/100 O2500/5000 PC10',
'BSNC0002 - NC SILV ValPls UNLM Fr PCP VV D4500/9000 O7950/15900 PC40',
'BSNC0003 - NC SILV ValPlsSav 3 PCP 6 VV Fr D4500/9000 O8700/17400 PC30',
'BSNC0004 - NC SILV-A ValPls UNLM Fr PCP VV AI0CS 0 CS',
'BSNC0005 - NC SILV-A ValPlsSav 3 PCP 6 VV Fr AI0CS 0 CS',
'EGNC0000 - NC ESI GOLD 3 PCP 6 VV Fr D1200/2400 O7250/14500 PC30',
'EGNC0001 - NC ESI GOLD D/V 3 PCP 6 VV Fr D1700/3400 O8000/16000 PC30',
'EGNC0002 - NC ESI GOLD-A 3 PCP 6 VV Fr AI0CS 0 CS',
'EGNC0003 - NC ESI GOLD-A D/V 3 PCP 6 VV Fr AI0CS 0 CS',
'ESCNC000 - NC ESI SILV-E 3 PCP 6 VV Fr CSR73 D2800/5600 O6800/13600 PC40',
'ESCNC001 - NC ESI SILV-D 3 PCP 6 VV Fr CSR87 D1200/2400 O2000/4000 PC25',
'ESCNC002 - NC ESI SILV-C 3 PCP 6 VV Fr CSR94 D0/0 O1400/2800 PC5',
'ESNC0000 - NC ESI SILV 3 PCP 6 VV Fr D3500/7000 O8000/16000 PC40',
'ESNC0001 - NC ESI SILV-A 3 PCP 6 VV Fr AI0CS 0 CS',
'VBNC0002 - NC BRON ValPls  D7900/15800 O8700/17400 PC40',
'VBNC0003 - NC BRON ValPls HSA D6700/13400 O7050/14100 PC30',
'VBNC0004 - NC BRON-A ValPls  AI0CS 0 CS',
'VBNC0005 - NC BRON-A ValPls AI0CS 0 CS',
'VSCNC003 - NC SILV-E ValPls 3 PCP 6 VV Fr CSR73 D3500/7000 O6900/13800 PC25',
'VSCNC004 - NC SILV-D ValPls 3 PCP 6 VV Fr CSR87 D1300/2600 O2900/5800 PC15',
'VSCNC005 - NC SILV-C ValPls 3 PCP 6 VV Fr CSR94 D40/80 O2900/5800 PC10',
'VSNC0002 - NC SILV ValPls 3 PCP 6 VV Fr D6800/13600 O8700/17400 PC35',
'VSNC0003 - NC SILV-A ValPls 3 PCP 6 VV Fr AI0CS 0 CS',
'ZPNC0000 - NC BRON EssenPls Low Prem D8700/17400 O8700/17400 PC0',
'ZPNC0001 - NC BRON-A EssenPls Low Prem AI0CS 0 CS')
order by cs.CSPProductDesc asc

--and
--Select *   from [cs].[IEXPlansDed]  
use btb
Select RwID,MemberGroupID,PlanID,CSPProductID,DoesDeductibleApply
--into testded
from 
(Select MemberGroupID,PlanID,CSPProductID,
	  [1],[2],[3],[21],[4],[9],[10],[11],[12],[74],
	  [13],[16],[79],[80],[15],[14],[81],[17],[18],
	  [19],[20],[75],[56],[22],[23],[24],[25],[30],
	  [28],[29],[31],[32],[33],[34],[26],[27],[5],
	  [8],[6],[35],[36],[37],[38],[39],[40],[41],
	  [82],[83],[84],[85],[86],[45],[42],[44],[43],
	  [46],[96],[49],[76],[47],[48],[50],[51],[52],
	  [53],[54],[55],[57],[58],[59],[60],[61],[98],
	  [62],[99],[100],[101],[77],[87],[88],[89],[63],
	  [90],[65],[69],[67],[71],[73],[78]  
	  from [cs].[IEXPlansDed] ) orig
	  UNPIVOT
	  ( DoesDeductibleApply for RwID IN ([1],[2],[3],[21],[4],[9],[10],[11],[12],[74],
	  [13],[16],[79],[80],[15],[14],[81],[17],[18],
	  [19],[20],[75],[56],[22],[23],[24],[25],[30],
	  [28],[29],[31],[32],[33],[34],[26],[27],[5],
	  [8],[6],[35],[36],[37],[38],[39],[40],[41],
	  [82],[83],[84],[85],[86],[45],[42],[44],[43],
	  [46],[96],[49],[76],[47],[48],[50],[51],[52],
	  [53],[54],[55],[57],[58],[59],[60],[61],[98],
	  [62],[99],[100],[101],[77],[87],[88],[89],[63],
	  [90],[65],[69],[67],[71],[73],[78] ) ) as UNPIV_RwIDs
	  where  MemberGroupID=40325 and 	PlanID=40690	and CSPProductID = 231
	  order by RwID asc
	  

	  Group By RwID
	  where MemberGroupID = 40325 and PlanID = 40690 and CSPProductID = 231

	  Select *  from #test
	  where  MemberGroupID=40325 and 	PlanID=40690	and CSPProductID = 231 order by 1 asc
,
Alter table IEX_Ded_diffrences add id int identity(1,1)
Select * from IEX_Ded_diffrences

	 -- Select DISTINCT cs.CSPProductID,cust.Name, mp.RwID,mp.RowLabel,CSPProductDesc,gv.*
Select gv.RwID , mg.MemberGroupID, gv.PlanID, cs.CSPProductID, DoesDeductibleApply
from CS.GppMedCostShareGridValues  gv
inner join CS.MemberGroupCSPProducts cs 
ON cs.CSPProductID = gv.CSPProductID 
inner join CS.GppMedCostShareRowMapping mp
ON mp.RwID = gv.RwID
inner join CS.MemberGroups mg on mg.MemberGroupID = gv.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
where  gv.MemberGroupID=40325 and 	gv.PlanID=40690	and cs.CSPProductID = 231
Select top 10 * from testded
--Update testded 
--SET DoesDeductibleApply = Case When DoesDeductibleApply = 'Y' THEN 612
--ELSE 613
--END

Select MGV.RwID FROM CS.GppMedCostShareGridValues MGV Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and GV.ID = 1


use btb
Declare @RowID INT = 1
Declare @RowCount INT



Select @RowCount = Count(*) from IEX_Ded_diffrences
Print @RowCount

While(@RowID <= @RowCount)
Begin
--If Exists( Select MGV.RwID FROM CS.GppMedCostShareGridValues MGV 
--Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
--and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and GV.ID = 1 and MGV.DoesDeductibleApply <> GV.DoesDeductibleApply)
--BEGIN
Update MGV 
SET
MGV.DoesDeductibleApply = GV.ExcelDed
FROM CS.GppMedCostShareGridValues MGV Inner join IEX_Ded_diffrences GV 
on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID and MGV.MemberGroupID = GV.MemberGroupID
 and MGV.RwID = GV.RwID and GV.ID = @RowID

Set @RowID = @RowID + 1
End





	 


	  
Select cust.Name as HealthPlan,MGV.MemberGroupID, MGV.PlanID, MGV.CSPProductID,cs.CSPProductDesc, MGV.RwID,mp.RowLabel,
MGV.DoesDeductibleApply,GV.DoesDeductibleApply as ExcelDed FROM CS.GppMedCostShareGridValues(nolock) MGV 
Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
inner join CS.MemberGroups mg on mg.MemberGroupID = MGV.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
inner join CS.GppMedCostShareRowMapping mp ON mp.RwID = MGV.RwID
inner join CS.MemberGroupCSPProducts cs ON cs.CSPProductID = MGV.CSPProductID 
and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and MGV.DoesDeductibleApply <> GV.DoesDeductibleApply
order by GV.RwID asc
where GV.rwID = 10


--Select cust.Name, mp.RwID,mp.RowLabel,CSPProductDesc,gv.* from CS.GppMedCostShareGridValues  gv
Select cust.Name,gv.MemberGroupID, gv.PlanID, gv.CSPProductID, gv.RwID,gv.DoesDeductibleApply,td.DoesDeductibleApply as Deducible_excel
from CS.GppMedCostShareGridValues  gv
inner join CS.MemberGroupCSPProducts cs 
ON cs.CSPProductID = gv.CSPProductID 
inner join CS.GppMedCostShareRowMapping mp
ON mp.RwID = gv.RwID
inner join CS.MemberGroups mg on mg.MemberGroupID = gv.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
--Inner join testded td on gv.CSPProductID = td.CSPProductID AND gv.PlanID = td.PlanID 
--and td.DoesDeductibleApply <> gv.DoesDeductibleApply
where 
mp.RwID IN( 4) and
--cs.CSPProductDesc = 'CSGWA000 - WA Cascade Select GOLD D500/1000 O5250/10500 PC20'
--and
 gv.MemberGroupID IN ( 40308,40313,40314,40315,40316,40317,40318,40319,40320,40321,40322,40323,40324,40325,40326)


 use btb
 

 Select * from IEX_Ded_diffrences

 Select * from ExcelDed

 




 from 
 
Select 
cust.Name as HealthPlan,MGV.MemberGroupID, MGV.PlanID, MGV.CSPProductID,cs.CSPProductDesc, MGV.RwID,mp.RowLabel,
MGV.DoesDeductibleApply,GV.DoesDeductibleApply as ExcelDed 
into IEX_Ded_diffrences
FROM CS.GppMedCostShareGridValues MGV 
Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
inner join CS.MemberGroups mg on mg.MemberGroupID = MGV.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
inner join CS.GppMedCostShareRowMapping mp ON mp.RwID = MGV.RwID
inner join CS.MemberGroupCSPProducts cs ON cs.CSPProductID = MGV.CSPProductID 
and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and MGV.DoesDeductibleApply <> GV.DoesDeductibleApply
order by GV.RwID asc


------------one shot copay 


use btb
Select * from [cs].[oneshot_copay1]


	[1],    [91],	[92],	[93],	[94],	[95],
	[103],	[97],	[102],	[2],	[3],	[21],	[4],	
	[9],	[10],	[11],	[12],	[74],	[13],	[16],	[79],
	[80],	[15],	[14],	[81],	[17],	[18],	[19],	[20],
	[75],	[56],	[22],	[23],	[24],	[25],	[30],	[28],
	[29],	[31],	[32],	[33],	[34],	[26],	[27],	[5],	
	[8],	[6],	[35],	[36],	[37],	[38],	[39],	[40],
	[41],	[82],	[83],	[84],	[85],	[86],	[45],	[42],	
	[44],	[43],	[46],	[96],	[49] ,  [76],	[47],	[48],	
	[50],	[51],	[52],	[53],	[54],	[55],	[57],   [58],
	[59],	[60],	[61],	[98],	[62],	[99],	[100],	[101],
	[77],	[87],	[88],	[89],	[63],	[90],	[65],	[69],
	[67],   [71],	[73],	[78]

	

Select MemberGroupID,PlanID,CSPProductID,

-------------------------------------COPAY MED COST SHARE UPDATE------------------------------------

use btb


sp_tables '%medcostshare%'
Select * from [CS].[allmarkets_copay1] as copay

--Select * into CS.GppMedCostShareGridValues_backup_before_allmarket from CS.GppMedCostShareGridValues

--Select top 10 * from CS.GppMedCostShareGridValues_backup_before_allmarket


--Select  top 10 cust.Name as HealthPlan,MGV.MemberGroupID, MGV.PlanID, MGV.CSPProductID,cs.CSPProductDesc, MGV.RwID,mp.RowLabel,
--MGV.CopayDollar 
--into #IEX_Copay_diffrences
Select * from #copay_toupdate where CspProductDesc = 'VSCAZ007 - AZ SILV-D ValPls 6 Fr VV CSR87 D12506339/2500 O2600/5200 PC20' order by CSPProductDesc asc 

Select DISTINCT cust.Name,MGV.MemberGroupID, MGV.PlanID, 
MGV.CSPProductID,
copay.[CSP Product Description] as allmarkets, cs.CSPProductDesc
--into IEX_Copay_allmarket
FROM CS.GppMedCostShareGridValues MGV 
--Inner join #testcopay GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID and GV.MemberGroupID = MGV.MemberGroupID
inner join CS.MemberGroups mg on mg.MemberGroupID = MGV.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
--inner join CS.GppMedCostShareRowMapping mp ON mp.RwID = MGV.RwID
inner join CS.MemberGroupCSPProducts cs ON cs.CSPProductID = MGV.CSPProductID 
left join [CS].[allmarkets_copay1] copay ON copay.[CSP Product Description] = cs.CSPProductDesc
where cs.CSPProductDesc = 'BBNC0002 - NC BRON ValPls 3 PCP 6 VV Fr D7600/15200 O8700/17400 PC50'
-- where copay.[CSP Product Description] = null 
--and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and MGV.CopayDollar <> GV.CopayDollar
order by cs.CSPProductDesc asc

Select 
MemberGroupID, PlanID, CSPProductID,CSPProductDesc from IEX_Copay_allmarket
inner join [CS].[allmarkets_copay1] 

Select members.MemberGroupID, members.PlanID, members.CSPProductID,members.CSPProductDesc as CSPProductDesc,
 [1],    [91],	[92],	[93],	[94],	[95],
	[103],	[97],	[102],	[2],	[3],	[21],	[4],	
	[9],	[10],	[11],	[12],	[74],	[13],	[16],	[79],
	[80],	[15],	[14],	[81],	[17],	[18],	[19],	[20],
	[75],	[56],	[22],	[23],	[24],	[25],	[30],	[28],
	[29],	[31],	[32],	[33],	[34],	[26],	[27],	[5],	
	[8],	[6],	[35],	[36],	[37],	[38],	[39],	[40],
	[41],	[82],	[83],	[84],	[85],	[86],	[45],	[42],	
	[44],	[43],	[46],	[96],	[49] ,  [76],	[47],	[48],	
	[50],	[51],	[52],	[53],	[54],	[55],	[57],   [58],
	[59],	[60],	[61],	[98],	[62],	[99],	[100],	[101],
	[77],	[87],	[88],	[89],	[63],	[90],	[65],	[69],
	[67],   [71],	[73],	[78] 
	into copay_toupdate 
	from [CS].[allmarkets_copay1] markets
inner join IEX_Copay_allmarket members ON members.CSPProductDesc = markets.[CSP Product Description]

Select * into copay_toupdate from #copay_toupdate order by CSPProductDesc asc

--Select * from CS.GppMedCostShareGridValues where 
Select * from copay_toupdate  order by CSPProductDesc asc

use btb
Select MemberGroupID,PlanID,CSPProductID,RwID,CopayDollar 
into #copay_all
from
(Select MemberGroupID,PlanID,CSPProductID,
	[1],    [91],	[92],	[93],	[94],	[95],
	[103],	[97],	[102],	[2],	[3],	[21],	[4],	
	[9],	[10],	[11],	[12],	[74],	[13],	[16],	[79],
	[80],	[15],	[14],	[81],	[17],	[18],	[19],	[20],
	[75],	[56],	[22],	[23],	[24],	[25],	[30],	[28],
	[29],	[31],	[32],	[33],	[34],	[26],	[27],	[5],	
	[8],	[6],	[35],	[36],	[37],	[38],	[39],	[40],
	[41],	[82],	[83],	[84],	[85],	[86],	[45],	[42],	
	[44],	[43],	[46],	[96],	[49] ,  [76],	[47],	[48],	
	[50],	[51],	[52],	[53],	[54],	[55],	[57],   [58],
	[59],	[60],	[61],	[98],	[62],	[99],	[100],	[101],
	[77],	[87],	[88],	[89],	[63],	[90],	[65],	[69],
	[67],   [71],	[73],	[78]
  from [copay_toupdate]) orig
  UNPIVOT 
  (CopayDollar for RwID IN ([1],    [91],	[92],	[93],	[94],	[95],
	[103],	[97],	[102],	[2],	[3],	[21],	[4],	
	[9],	[10],	[11],	[12],	[74],	[13],	[16],	[79],
	[80],	[15],	[14],	[81],	[17],	[18],	[19],	[20],
	[75],	[56],	[22],	[23],	[24],	[25],	[30],	[28],
	[29],	[31],	[32],	[33],	[34],	[26],	[27],	[5],	
	[8],	[6],	[35],	[36],	[37],	[38],	[39],	[40],
	[41],	[82],	[83],	[84],	[85],	[86],	[45],	[42],	
	[44],	[43],	[46],	[96],	[49] ,  [76],	[47],	[48],	
	[50],	[51],	[52],	[53],	[54],	[55],	[57],   [58],
	[59],	[60],	[61],	[98],	[62],	[99],	[100],	[101],
	[77],	[87],	[88],	[89],	[63],	[90],	[65],	[69],
	[67],   [71],	[73],	[78])) as UNPIV_RwIDs
	

	Select top  10 * from #copay_all 
	
	where CSPProductID = 418 
	use btb	
		--Select COUNT(*) from [CS].GppMedCostShareGridValues_backup_before_allmarket
Select
cust.Name as HealthPlan,MGV.MemberGroupID, MGV.PlanID, MGV.CSPProductID,cs.CSPProductDesc, MGV.RwID,mp.RowLabel,
MGV.CopayDollar, GV.CopayDollar, cs.CSPProductDesc
--,GV.CoinsPercent as Excel_CoinsPer
--into #IEX_Coins_diffrences
--Select MGV.CopayDollar, GV.CopayDollar
FROM CS.GppMedCostShareGridValues MGV 
inner join #copay_all  GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
and GV.MemberGroupID = MGV.MemberGroupID
inner join CS.MemberGroups mg on mg.MemberGroupID = MGV.MemberGroupID
inner join CS.Customers cust on mg.CustomerID = cust.CustomerID
inner join CS.GppMedCostShareRowMapping mp ON mp.RwID = MGV.RwID
inner join CS.MemberGroupCSPProducts cs ON cs.CSPProductID = MGV.CSPProductID 
and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID where 
--GV.MemberGroupID = 40308 and GV.PlanID = 40671 and GV.CSPProductID= 213 and GV.RwID = 101
--MemberGroupID	PlanID	CSPProductID	RwID	CopayDollar
--40308	40671	213	101	30
 MGV.CopayDollar <> GV.CopayDollar
--and 
cs.CSPProductDesc like '%BVBAL000%' and MGV.RwID = 62
order by cs.CSPProductDesc asc

Select cs.MemberGroupID,cs.PlanID,cs.CSPProductID,cs.RwID,cs.CopayDollar from  #copay_all cs left join CS.GppMedCostShareGridValues MGV
ON cs.CSPProductID = MGV.CSPProductID 
and MGV.MemberGroupID = cs.MemberGroupID and MGV.RwID = cs.RwID
where cs.RwID <> MGV.RwID


Select cs.MemberGroupID,cs.PlanID,cs.CSPProductID,cs.RwID,CopayDollar from  #copay_all cs
Except 
Select MGV.MemberGroupID,MGV.PlanID,MGV.CSPProductID,MGV.RwID,MGV.CopayDollar from  CS.GppMedCostShareGridValues MGV


Select Count(*) from #copay_all
Select * into 
CS.GppMedCostShareGridValues_bkup from CS.GppMedCostShareGridValues


Alter table #copay_all add id int identity(1,1)

Select * from #copay_all

--BEGIN TRAN
--ROLLBACK TRAN
--COMMIT TRAN

use btb
Declare @RowID INT = 1
Declare @RowCount INT



Select @RowCount = Count(*) from #copay_all
Print @RowCount

While(@RowID <= @RowCount)
Begin
--If Exists( Select MGV.RwID FROM CS.GppMedCostShareGridValues MGV 
--Inner join testded GV on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID 
--and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and GV.ID = 1 and MGV.DoesDeductibleApply <> GV.DoesDeductibleApply)
--BEGIN
Update MGV 
SET
MGV.CopayDollar = GV.CopayDollar

FROM CS.GppMedCostShareGridValues MGV Inner join #copay_all  GV 
on MGV.CSPProductID = GV.CSPProductID AND MGV.PlanID = GV.PlanID and MGV.MemberGroupID = GV.MemberGroupID
 and MGV.RwID = GV.RwID and GV.ID = @RowID

Set @RowID = @RowID + 1
End


Declare @RowID INT = 1
Declare @RowCount INT

Select @RowCount = Count(*) from #copay_all 

While(@RowID <= @RowCount)
Begin
If Exists( Select  MGV.RwID FROM CS.GppMedCostShareGridValues MGV Inner join #copay_all GV 
on  MGV.PlanID = GV.PlanID and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID and GV.ID = @RowID)
BEGIN
Update MGV Set CopayDollar =  GV.CopayDollar 
FROM CS.GppMedCostShareGridValues MGV 
Inner join #copay_all GV on MGV.PlanID = GV.PlanID 
and MGV.MemberGroupID = GV.MemberGroupID and MGV.RwID = GV.RwID 
and GV.ID = @RowID 
END
ELSE
BEGIN
INSERT INTO [CS].[GppMedCostShareGridValues]
([MemberGroupID],[PlanID],[CSPProductID],[RwID],[CopayDollar],[CoinsPercent],[ApplyCoinsToDed],[Comments],[DoesDeductibleApply]
,[AreMedRxDedCombined],[MedInnIndDed],[MedInnFamDed],[MedInnIndOopm],[MedInnFamOopm],[Covered])
Select MemberGroupID, PlanID,CSPProductID, RwID, cv.CopayDollar, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL, NULL
From #copay_all cv
Where cv.ID = @RowID

--FROM dbo.ExportIEXPlans_Covered$ Where ID = @RowID
END

Set @RowID = @RowID + 1
End






--