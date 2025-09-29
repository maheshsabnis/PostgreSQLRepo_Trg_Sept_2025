Create or replace function get_sum_salary_group_by_deptno()
returns table (result_deptno integer, sum_salary numeric(12,2)) as $$
begin 
	return query
	select deptno, sum(salary) from employee
	group by deptno;
end;
$$ Language plpgsql;

-- Invoke function

select * from get_sum_salary_group_by_deptno();

DROP FUNCTION get_sum_salary_group_by_deptno();

select deptno, sum(salary) from employee
	group by deptno;