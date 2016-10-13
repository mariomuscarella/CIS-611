USE COMPANY
GO

CREATE VIEW VDept_Budget AS 
SELECT D.Dname as Dept_Name, D.Dnumber as Dept_Number, COUNT(E.Ssn) as No_Emp,
		sum(E.Salary) as Sum_Salary, AVG(E.Salary) as Ave_Salary
	FROM DEPARTMENT D LEFT OUTER JOIN EMPLOYEE E ON E.Dno = D.Dnumber
GROUP BY D.Dname, D.Dnumber
GO

SELECT* FROM VDept_Budget