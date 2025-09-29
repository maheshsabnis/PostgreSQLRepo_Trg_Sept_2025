-- Create Department Table
Create table Department(
 DeptNo smallint Not Null,
 DeptName varchar(100) Not Null,
 Location varchar(100) Not Null,
 Primary Key (DeptNo) 	
);
-- Altering the Type of the Column
Alter Table Department Alter Column DeptNo Type integer;
-- Altering table by adding new column 
Alter table Department Add Column Capacity integer Not Null;
-- Altering table by adding a unique constraint
Alter table Department Add Constraint DeptNameUniqueConstraint 
Unique(DeptName);


-- Creating Employee Tale with Foreign Key
CREATE TABLE Employee (
    EmpNo       SERIAL PRIMARY KEY,
    EmpName     VARCHAR(100) NOT NULL,
    Designation VARCHAR(50),
    Salary      NUMERIC(10, 2),
    DeptNo      INTEGER REFERENCES Department(DeptNo) ON DELETE SET NULL,
    -- Foreign key to Department table
    CONSTRAINT fk_department FOREIGN KEY (DeptNo)
        REFERENCES Department(DeptNo)
        ON DELETE SET NULL
);

-- Insert Records
insert into Department values(10, 'TR', 'Pune', 25);
insert into Department values(20, 'IT', 'Pune', 25);
insert into Department values(30, 'SL', 'Pune', 25);
insert into Department values(40, 'AD', 'Pune', 25);
insert into Department values(50, 'TP', 'Pune', 25);
insert into Department values(60, 'SU', 'Pune', 35);



insert into Employee Values(103, 'Suprotim', 'Director', 110000,10);
insert into Employee Values(104, 'Subodh', 'Director', 120000,10);
insert into Employee Values(105, 'Abhijit', 'Manager', 110000,10);
insert into Employee Values(106, 'Manish', 'CEO', 200000,20);
insert into Employee Values(107, 'Deepak', 'Manager', 90000,30);
insert into Employee Values(108, 'Pravin', 'Leader', 120000,40);
insert into Employee Values(109, 'Sumit', 'Leader', 340000,50);
insert into Employee Values(110, 'Sachin', 'Manager', 180000,10);
insert into Employee Values(111, 'Ravi', 'Director', 240000,20);
insert into Employee Values(112, 'Kiran', 'Leader', 260000,30);
insert into Employee Values(113, 'Dinesh', 'Leader', 670000,40);
insert into Employee Values(114, 'Vikas', 'Manager', 230000,50);
insert into Employee Values(115, 'Ajit', 'Leader', 340000,10);
insert into Employee Values(116, 'Amit', 'Director', 450000,20);
insert into Employee Values(117, 'Tejas', 'Director', 360000,30);
insert into Employee Values(118, 'Vivek', 'Manager', 130000,40);
insert into Employee Values(119, 'Anil', 'Manager', 560000,50);
insert into Employee Values(120, 'Abhay', 'Director', 550000,10);
insert into Employee Values(121, 'Jaywant', 'Director', 550000,20);
insert into Employee Values(122, 'Nandu', 'Director', 660000,30);



SELECT json_agg(row_to_json(e))
FROM (SELECT * FROM Employee) e;









