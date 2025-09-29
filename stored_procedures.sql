Select * from employee

Create Procedure sp_insert_employee(
	p_empno integer,
	p_empname varchar(100),
	p_designation varchar(100),
	p_salary numeric(10,2),
	p_deptno integer
)
Language plpgsql
As $$
Begin
	insert into employee(empno,empname,designation,salary, deptno)
	values
	(p_empno, p_empname,p_designation, p_salary,p_deptno);
End;
$$

-- execute procedure
call sp_insert_employee(123, 'Sagar', 'Architect', 5980000,10);
-- Alter te procedure
create or replace procedure sp_insert_employee(
	p_empno integer,
	p_empname varchar(100),
	p_designation varchar(100),
	p_salary numeric(10,2),
	p_deptno integer
)

As $$
Begin
    if p_deptno <= 0 or p_salary<=0 Then
		Raise 'Make sure that, the numeric values must be positive';
	end if;
	insert into employee(empno,empname,designation,salary, deptno)
	values
	(p_empno, p_empname,p_designation, p_salary,p_deptno);
End;
$$ Language plpgsql;


-- execute procedure
call sp_insert_employee(124, 'Sushrut', 'CTO', 59800000,10);






