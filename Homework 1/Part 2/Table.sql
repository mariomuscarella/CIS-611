USE COMPANY
GO

IF OBJECT_ID (N'dbo.Dept_Productivity', N'TF') IS NOT NULL
	DROP FUNCTION DBO.Dept_Productivity;
GO

CREATE FUNCTION Dept_Productivity ()
RETURNS @Total_Dept_Productivity_Table TABLE
	(
	Dept_Name char(30),
	Dept_Number int,
	EmpCount int,
	Sum_Salary int,
	ProjectCount int
	)

AS
BEGIN
INSERT INTO @Total_Dept_Productivity_Table
	Select D.Dname as Dept_name, E.Dno as Dept_Number, Count(E.Dno) as EmpCount,
	 SUM(E.Salary) as Sum_Salary, Count(P.Pnumber) as ProjectCount
FROM EMPLOYEE E
join DEPARTMENT D ON E.Dno = D.Dnumber
join PROJECT P ON P.Pnumber = P.Dnum
GROUP BY E.Dno, D.Dname
	RETURN;
END;