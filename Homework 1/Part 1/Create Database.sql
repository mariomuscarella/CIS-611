/* drop database COMPANY; */
 
/* create database COMPANY; */

/* USE COMPANY; */

/*EMPLOYEE TABLE -----------------------------------------------------------------*/

/* Deleting EMPLOYEE table */
drop table EMPLOYEE;

/*Creating EMPLOYEE table*/
create table EMPLOYEE (
	Fname varchar(20)	NOT NULL,
	Minit varchar(12),
	Lname varchar(20)	NOT NULL,
	Ssn varchar(12)		NOT NULL,
	Bdate varchar(12),
	Address varchar(50)	NOT NULL,
	Sex varchar(6),
	Salary int	NOT NULL,
	Super_ssn varchar(12),
	Dno varchar(12),
	PRIMARY KEY (Ssn)
);

/*Inserting data to the EMPLOYEE table*/
insert into EMPLOYEE(Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno ) values 
	('John', 'B', 'Smith', 123456789, '09-Jan-55', '731 Fondren, Houston, TX', 'M', '30000', '987654321', '5'),
	('Franklin', 'T', 'Wong', 333445555, '08-Dec-45' , '938 Voss, Houston, TX' ,'M' ,'40000' ,'888665555', '5'),
	('Joyce', 'A', 'English', 453453453, '31-Jul-62', '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5'),
	('Ramesh', 'K', 'Narayan', 666884444, '15-Sep-52', '975 Fire Oak, Humble, TX', 'M', '38000', '333445555', '5'),
	('James', 'E', 'Borg', 888665555, '10-Nov-27', '450 Stone, Houston, TX', 'M', '55000', NULL, '1'),
	('Jennifer', 'S', 'Wallace', 987654321, '20-Jun-31', '291 Berry, Bellaire, TX', 'F', '43000', '888665555', '4'),
	('Ahmad', 'V', 'Jabbar', 987987987, '29-Mar-59', '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4'),
	('Alicia', 'J', 'Zelaya', 999887777, '19-Jul-58', '3321 Castle, SPring, TX', 'F', '25000', '0987654321', '4');

/*Displaying the EMPLOYEE table */
select * from EMPLOYEE;



/*DEPARTMENT TABLE ----------------------------------------------------------------- */

/* Deleting DEPARTMENT table */
drop table DEPARTMENT;

/*Creating DEPARTMENT table */
create table DEPARTMENT (
	Dname varchar(30),
	Dnumber int			NOT NULL,
	Mgrssn varchar(12)	NOT NULL,
	Mgrstartdate varchar(12),
	PRIMARY KEY (Dnumber)
);

/* Inserting data to the DEPARTMENT table */
insert into DEPARTMENT(Dname, Dnumber,Mgrssn, Mgrstartdate ) values 
	('Headquarters', 1, 888665555, '19-Jun-71'),
	('Administration', 4, 987654321, '01-Jan-85'),
	('Research', 5, 333445555, '22-May-78'),
	('Automation', 7, 123456789, '06-Oct-05');
	
	

/* Displaying the DEPARTMENT table */
select * from DEPARTMENT;



/* DEPT_LOCATIONS TABLE ----------------------------------------------------------------- */

/* Deleting DEPT_LOCATIONS table */
drop table DEPT_LOCATIONS;

/* Creating DEPT_LOCATIONS table */
create table DEPT_LOCATIONS (
	Dnumber int				NOT NULL,
	Dlocation varchar(30)	NOT NULL,
	PRIMARY KEY (Dnumber, Dlocation)
);

/* Inserting data to the DEPT_LOCATIONS table */
insert into DEPT_LOCATIONS(Dnumber, Dlocation) values 
	(1, 'Houston'),
	(4, 'Stafford'),
	(5, 'Bellaire'),
	(5, 'Sugarland'),
	(5, 'Houston');

/* Displaying the DEPT_LOCATIONS table */
select * from DEPT_LOCATIONS;





/* PROJECT TABLE ----------------------------------------------------------------- */

/* Deleting PROJECT table */
drop table PROJECT;

/* Creating PROJECT table */
create table PROJECT (
	Pname varchar(30),
	Pnumber int,
	Plocation varchar(20),
	Dnum int,
	PRIMARY KEY (Pnumber)
);

/* Inserting data to the PROJECT table */
insert into PROJECT(Pname, Pnumber, Plocation, Dnum) values
	('ProductX', 1, 'Bellaire', 5),
	('ProductY', 2, 'Sugarland', 5),
	('ProductZ', 3, 'Houston', 5),
	('Computerization', 10, 'Stafford', 4),
	('Reorganization', 20, 'Houston', 1),
	('NewBenefits', 30, 'Stafford', 4);

/* Displaying the PROJECT table */
select * from PROJECT;

/* WORKS_ON TABLE ----------------------------------------------------------------- */

/* Deleting WORKS_ON table */
drop table WORKS_ON;

/*Creating WORKS_ON table */
create table WORKS_ON (
	Essn varchar(12) not null,
	Pno int not null,
	Hours varchar(12),
	UNIQUE (Essn, Pno)
);

/* Inserting data to the WORKS_ON table */
insert into WORKS_ON(Essn, Pno, Hours) values
	(123456789, 1, '32.5'),
	(123456789, 2, '7.5'),
	(333445555, 2, '10'),
	(333445555, 3, '10'),
	(333445555, 10, '10'),
	(333445555, 20, '10'),
	(453453453, 1, '20'),
	(453453453, 2, '20'),
	(666884444, 3, '40'),
	(888665555, 20, NULL),
	(987654321, 20, '15'),
	(987654321, 30, '20'),
	(987987987, 10, '35'),
	(987987987, 30, '5'),
	(999887777, 10, '10'),
	(999887777, 30, '30');

/* Displaying the WORKS_ON table */
select * from WORKS_ON;



/* DEPENDANT TABLE ----------------------------------------------------------------- */ 

/* Deleting DEPENDENT table */
drop table DEPENDENT;

/* Creating DEPENDANT table */
create table DEPENDENT (
	Essn varchar(12),
	Dependent_name varchar(30),
	Sex varchar(6),
	Bdate varchar(12),
	Relationship varchar(20),
	PRIMARY KEY (Essn, Dependent_name)
);

/* Inserting data to the DEPENDANT table */
insert into DEPENDENT(Essn, Dependent_name, Sex, Bdate, Relationship) values
	(123456789, 'Alice', 'F' ,'31-Dec-78', 'Daughter'),
	(123456789, 'Elizabeth', 'F' ,'05-May-57', 'Spouse'),
	(123456789, 'Michael', 'M' ,'01-Jan-78', 'Son'),
	(333445555, 'Alice', 'F', '05-Apr-76', 'Daughter'),
	(333445555, 'Joy', 'F', '03-May-48', 'Spouse'),
	(333445555, 'Theodore', 'M', '25-Oct-73', 'Son'),
	(987654321, 'Abner', 'M', '29-Feb-32', 'Spouse');

/* Displaying the DEPENDANT table */
select * from DEPENDENT; 

