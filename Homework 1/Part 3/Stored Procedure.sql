USE COMPANY
GO

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
CREATE PROCEDURE [dbo].[SP_NEW_Total_Salary_By_Dept]

AS
BEGIN

	IF NOT EXISTS (SELECT* FROM sys.objects where
	object_id=object_id(N'[dbo].[NEW_Total_Salary_By_Dept]') AND TYPE IN (N'U'))

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   DECLARE @dept_ID int;
   DECLARE @dept_Name varchar(50);
   DECLARE @no_of_emp int;
   DECLARE @Sum_Salary int;
   DECLARE @Avg_Salary int;

   CREATE TABLE NEW_Total_Salary_By_Dept
   (
   Dept_No int, 
   Dept_Name char(30),
   Count_Emp int,
   New_Sum_Salary int,
   New_Avg_Salary int
   );

   DECLARE @is_EMPTY int;  
   set @is_EMPTY = (select count(*) from VDept_Budget); 
    
	if(@is_EMPTY>0)  
	Begin       
	
	DECLARE @no_more_data int;   
	DECLARE @new_SALARY int;  
	DECLARE @new_AVGSALARY int;   
	set @no_more_data = @is_empty;   
	DECLARE switch_CURSOR CURSOR LOCAL for select Dept_Name,Dept_Number,No_Emp, Sum_Salary, Ave_Salary from VDept_Budget;   
	
	OPEN switch_CURSOR;   
	FETCH NEXT FROM switch_CURSOR into @dept_NAME, @dept_ID, @no_of_EMP, @sum_SALARY, @avg_SALARY;  
	 
	while(@@FETCH_STATUS = 0)   
	BEGIN     
	set @new_SALARY = @sum_SALARY;  
	IF(@dept_ID = 1)    
    BEGIN      
	set @new_SALARY = @sum_SALARY + (@sum_SALARY * 10/100);   
	END    
	ELSE IF(@dept_ID = 4)     
	BEGIN      
	set @new_SALARY = @sum_SALARY + (@sum_SALARY * 20/100);     
	END    
	ELSE IF(@dept_ID = 5)     
	BEGIN      
	set @new_SALARY = @sum_SALARY + (@sum_SALARY * 30/100);     
	END    
	ELSE IF(@dept_ID = 7)     
	BEGIN      
	set @new_SALARY = @sum_SALARY + (@sum_SALARY * 40/100);     
	END
	      
	set @new_AVGSALARY = @new_SALARY / @no_of_EMP ;   
	insert into NEW_Total_Salary_By_Dept (Dept_No,Dept_Name,COUNT_Emp,New_SUM_Salary,New_AVG_Salary) values (@dept_ID,@dept_NAME,@no_of_EMP,@sum_SALARY,@avg_SALARY);  
	
	FETCH switch_CURSOR into @dept_NAME, @dept_ID, @no_of_EMP, @sum_SALARY, @avg_SALARY;  
	END   
	close switch_CURSOR;  
	
	End  
	else    
	
	BEGIN    
	PRINT 'VDept_Budget in empty'   
	END    
 
 select * from NEW_Total_Salary_By_Dept; 

END

exec SP_NEW_Total_Salary_By_Dept
