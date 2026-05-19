-- correlated subquery vs JOIN+GROUPBY query
-----------------------------------------------

-- problem : Calculate the total amount each customer has spent by summing all their orders.
-- sources : samples.tpch.customer, samples.tpch.orders

-- 1. correlated subquery ->
select
c.c_custkey,
c.c_name,
(select
    sum(o_totalprice)
    from
    samples.tpch.orders o
    where 
    o.o_custkey = c.c_custkey
) as total_spent
from
samples.tpch.customer c;
-- 38s 

-- This query : For each customer, SQL runs the inner query.
             -- The inner query filters orders for that specific customer.
             -- If there are 150,000 customers, the subquery runs 150,000 times.
             -- row-by-row execution.



-- 2. JOIN+GROUPBY query ->
select
c.c_custkey,
c.c_name,
sum(o.o_totalprice) as total_spent
from
samples.tpch.customer c
left join samples.tpch.orders o
on c.c_custkey = o.o_custkey
group by
c.c_custkey,
c.c_name;
-- 3s 

-- This query : SQL runs the inner query once.
             -- The inner query filters orders for all customers.
             -- Set‑based execution.

------------------------------------------------------------------------------------------------------------------------------------------------------