USE COMPANY
GO

INSERT INTO [dbo].[EMPLOYEE]
	([Fname],[Minit],[Lname],[Ssn],[Bdate],[Address],[Sex],[Salary],[Super_ssn],[Dno])
VALUES
	('Mario','S','Muscarella','999999999','10-Apr-1985','1111 Road, Cleveland, Ohio','M',70000,null,7)
GO 

INSERT INTO [dbo].[WORKS_ON]
	([Essn],[Pno],[Hour])
VALUES
	(999999999,1,100)
GO 

INSERT INTO [dbo].[DEPENDENT]
	([Essn],[Dependent_name],[Sex],[Bdate],[Relationship])
VALUES
	('9999999999','Master Cylinder','M','12-JUL-2016','Cat')
GO

SELECT*
FROM EMPLOYEE E, DEPENDENT D, WORKS_ON W
	WHERE D.Essn = E.Ssn
		AND W.Essn = E.Ssn
		AND E.Ssn = '999999999'