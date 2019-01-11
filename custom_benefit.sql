select 
	rtrim(DistrictAbbrev) 
from tblDistrict

select 
	te.EmployeeID,
	te.LName,
	te.FName,
	te.MI,
	te.SocSecNo,
	cl.ClassDescription,
	null as [Deduction Type],
	act.TypeDesc as [Deduction Plan],
	null as [Policy Coverage],
	null as [Effective Payroll],
	null as [Inactive Payroll],
	null as [Total Cost],
	null as [District Contribution],
	null as [Note],
	acct.AccountString as [Custom Funding Account],
	ef.[Percent] as [Funding Percent],
	ef.Notes as [Custom Funding Notes]
from tblEmployee te
inner join
	tblClassifications cl
	on te.ClassificationId = cl.ClassificationID
inner join
	tblActionDue ad
	on ad.adEmployeeID = te.EmployeeID
inner join
	tblActionType act
	on ad.ActionTypeID = act.ActionTypeID
inner join
	DS_Global..tblActionTypeCategory atc
	on act.ActionTypeCategoryID = atc.ActionTypeCategoryID
	and atc.ActionTypeCategoryID in (7,4,6,22,23,24,25,26)
left join
	EmployeeFunding ef
	on ef.EmployeeId = te.EmployeeID
left join
	tblAccount acct
	on acct.AccountID = ef.AccountId
order by te.Fullname asc
