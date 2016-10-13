SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_Total_Salary_By_Dept
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	CREATE TABLE Total_Salary_By_Dept
	(
	Dept_Name varchar(20),
	Dept_Number int,
	EmpCount int,
	Sum_Salary int,
	Ave_Salary int
	);

	INSERT INTO Total_Salary_By_Dept
	(Dept_Name, Dept_Number, EmpCount, Sum_Salary, Ave_Salary)
	SELECT Dept_Name, Dept_Number, No_Emp as'Count_Emp', Sum_Salary, 
	Ave_Salary
	FROM VDept_Budget V LEFT JOIN PROJECT P on Dept_Number = P.Dnum
	GROUP BY Dept_Name, Dept_Number, No_Emp, Sum_Salary,Ave_Salary;

	SELECT* FROM Total_Salary_By_Dept;
END

EXEC SP_Total_Salary_By_Dept
