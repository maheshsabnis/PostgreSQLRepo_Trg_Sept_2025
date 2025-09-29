---- STored Procedute with the out parameter
create or replace procedure sp_get_tax_for_employee(
   IN p_empno integer,
   OUT p_tax numeric(10,2)
)
As $$
 declare 
   	emp_record Record;
	v_salary numeric(10,2);
Begin
   -- check if the employee is present based on the empno
  
   select * into emp_record from employee
  	 where empno = p_empno;
   if  Not Found Then
   	Raise exception 'The employee with empno = % is not found.', p_empno;
   end if;  	
   -- first select the salary of the employee based on the empno
  
   
   select salary into v_salary from employee where empno=p_empno;
   if v_salary is Null Then
   		RAISE EXCEPTION 'The salary for employee empno = % is not found.', p_empno;
   end if;
   -- calculate tax
   p_tax = v_salary * 0.3;
End;
$$ Language plpgsql

-- Execute SP with Out Paramaters
DO $$
Declare
  p_tax numeric(10,2);
begin
  call sp_get_tax_for_employee(103, p_tax);
  Raise Notice 'Tax is %', p_tax;
end;
$$

-- Check if the Stored Procedure is present or not
SELECT proname, proargtypes
FROM pg_proc
WHERE proname = 'sp_get_tax_for_employee';
-- The path for the Configuration file
SHOW config_file;

-- List the available extensions

SELECT * FROM pg_available_extensions;


SELECT name, setting FROM pg_settings WHERE name = 'shared_preload_libraries';



