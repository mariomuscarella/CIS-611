-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_Dept_Productivity
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	CREATE TABLE Dept_Productivity
	(
	Dept_Name varchar(20),
	Dept_Number int,
	EmpCount int,
	Sum_Salary int,
	ProjectCount int
	);

	INSERT INTO Dept_Productivity
	(Dept_Name, Dept_Number, EmpCount, Sum_Salary, ProjectCount)
	SELECT Dept_Name, Dept_Number, No_Emp as'EmpCount', Sum_Salary, 
	COUNT(P.Dnum) as 'ProjectCount'
	FROM VDept_Budget V LEFT JOIN PROJECT P on Dept_Number = P.Dnum
	GROUP BY Dept_Name, Dept_Number, No_Emp, Sum_Salary,P.Dnum;

	SELECT* FROM Dept_Productivity;
END
