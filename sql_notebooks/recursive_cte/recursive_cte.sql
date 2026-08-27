
with recursive emp_cte as(
    select 
    empname,
    managername,
    empname as root_emp,
    managername as current_manager
    from 
    emp

    union all

    select 
    e1.empname,
    e1.managername,
    e2.root_emp,
    e1.managername as current_manager
    from emp e1
    join emp_cte e2 on
    e1.empname = e2.current_manager
)

select 
root_emp as empname,
string_agg(current_manager,',') as managers
from emp_cte
group by root_emp
order by root_emp;


-----------------------------------------------------------------------------------------------------------

-- rank emps by heirarchy

with recursive rank_cte as
(
    select empname,
    managername,
    1 as rank
    from emp 
    where managername is null

    union all

    select 
    e.empname,
    e.managername,
    c.rank+1 as rank
    from emp e
    join rank_cte c on
    e.managername = c.empname
)

select * from
rank_cte
order by rank;
