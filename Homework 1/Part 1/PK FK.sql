/* drop database COMPANY; */

/* create database COMPANY; */

USE COMPANY; 

ALTER TABLE DEPARTMENT 
ADD Foreign KEY (Mgrssn) References EMPLOYEE(Ssn); 
GO 
ALTER TABLE EMPLOYEE 
ADD Foreign KEY (Dno) References DEPARTMENT(Dnumber), Foreign KEY (Super_ssn) References EMPLOYEE(Ssn);
GO 
ALTER TABLE DEPT_LOCATIONS 
ADD Foreign Key (Dnumber) References DEPARTMENT(Dnumber) 
GO 
ALTER TABLE PROJECT 
ADD Foreign Key (Dnum) References DEPARTMENT(Dnumber) 
GO 
ALTER TABLE WORKS_ON ADD Foreign Key (Pno) References PROJECT(Pnumber), Foreign Key (Essn) References EMPLOYEE(Ssn); 
GO 
ALTER TABLE DEPENDENT 
ADD Foreign Key (Essn) References EMPLOYEE (Ssn) 
GO
