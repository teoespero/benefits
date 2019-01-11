select 
	rtrim(DistrictAbbrev) 
from tblDistrict

SELECT
  [Employee].EmployeeID,
  [Employee].[LName] AS [Last Name],
  [Employee].[FName] AS [First Name],
  [Employee].[MI] AS [Middle Initial],
  [Employee].[SocSecNo] AS [SSN],
  [ClassificationEmployee].[ClassDescription] AS [Classification],
  [PyDeductionType_Template].[Description] AS [Deduction Type],
  [PyDeductionPlan_Template].[DeductionPlan] AS [Deduction Plan],
  [PyDeductionPolicy_Template].[Policy] AS [Policy Coverage],
  [Payroll_DeductionTemplateEffective].[PayPeriod] AS [Effective Payroll],
  [Payroll_DeductionTemplateInActive].[PayPeriod] AS [Inactive Payroll],
  [PyDeductionTemplate].[Amount] AS [Total Cost],
  [PyDeductionTemplate].[DistrictAmount] AS [District Contribution],
  [PyDeductionTemplate].[Note] AS [Note],
  null as [Custom Funding Account],
  null as [Funding Percent],
  null as [Custom Funding Notes]
FROM [tblEmployee] [EMPLOYEE]
INNER JOIN [tblClassifications] [CLASSIFICATIONEMPLOYEE]
  ON ([EMPLOYEE].[ClassificationId] = [CLASSIFICATIONEMPLOYEE].[ClassificationID])
INNER JOIN [PyDeductionTemplate] [PYDEDUCTIONTEMPLATE]
LEFT JOIN [tblPayroll] [PAYROLL_DEDUCTIONTEMPLATEEFFECTIVE]
  ON ([PYDEDUCTIONTEMPLATE].[EffectivePayrollId] = [PAYROLL_DEDUCTIONTEMPLATEEFFECTIVE].[PayrollID])
LEFT JOIN [tblPayroll] [PAYROLL_DEDUCTIONTEMPLATEINACTIVE]
  ON ([PYDEDUCTIONTEMPLATE].[InactivePayrollId] = [PAYROLL_DEDUCTIONTEMPLATEINACTIVE].[PayrollID])
INNER JOIN [PyDeductionPlan] [PYDEDUCTIONPLAN_TEMPLATE]
INNER JOIN DS_Global..PyDeductionType [PYDEDUCTIONTYPE_TEMPLATE]
  ON ([PYDEDUCTIONPLAN_TEMPLATE].[PyDeductionTypeId] = [PYDEDUCTIONTYPE_TEMPLATE].[Id])
  ON ([PYDEDUCTIONTEMPLATE].[PyDeductionPlanId] = [PYDEDUCTIONPLAN_TEMPLATE].[Id])
LEFT JOIN [PyDeductionPolicy] [PYDEDUCTIONPOLICY_TEMPLATE]
  ON ([PYDEDUCTIONTEMPLATE].[PyDeductionPolicyId] = [PYDEDUCTIONPOLICY_TEMPLATE].[Id])
  ON ([EMPLOYEE].[EmployeeID] = [PYDEDUCTIONTEMPLATE].[EmployeeId])
WHERE ([PyDeductionTemplate].[InactivePayrollId] IS NULL)
AND (((EMPLOYEE.HireDate IS NULL
OR EMPLOYEE.HireDate < '7/1/2019')
AND (EMPLOYEE.TerminateDate IS NULL
OR EMPLOYEE.TerminateDate > '6/30/2018')))
ORDER BY [Employee].[LName], [Employee].[FName], [Employee].[MI], [Employee].[SocSecNo], [ClassificationEmployee].[ClassDescription], [PyDeductionType_Template].[Description], [PyDeductionPlan_Template].[DeductionPlan], [PyDeductionPolicy_Template].[Policy], [Payroll_DeductionTemplateEffective].[PayPeriod], [Payroll_DeductionTemplateInActive].[PayPeriod], [PyDeductionTemplate].[Amount], [PyDeductionTemplate].[DistrictAmount], [PyDeductionTemplate].[Note]








