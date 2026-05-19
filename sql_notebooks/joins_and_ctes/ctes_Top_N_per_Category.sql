-- source  :  samples.tpch.part, samples.tpch.lineitem
-- columns : lineitem.l_extendedprice, part.p_partkey, part.p_name

-- Problem : Find top 3 parts by total revenue.

-- Without CTE/Ranking
-- Aggregation → wrapped in an unnamed subquery → ORDER BY → LIMIT.
-- Harder to read. No name for the intermediate result. Not reusable. OK for very small one‑off queries. Becomes messy as logic grows.
select * 
from(
select 
p.p_partkey,
p.p_name,
sum(l.l_extendedprice) as total_part_amount
from 
samples.tpch.part p
join samples.tpch.lineitem l
on p.p_partkey = l.l_partkey
group by p.p_partkey, p.p_name
)
order by total_part_amount
limit 3 ;

----------------------------------------------------------------------------------------------------------------------------------------------

-- with CTE / No ranking
-- CTE computes totals → main query orders + limits.
-- Much cleaner than subquery. Intermediate result has a name (total_revenue). Easy to debug. Easy to extend. Standard practice in production SQL.
with total_revenue as (
  select 
p.p_partkey,
p.p_name,
sum(l.l_extendedprice) as total_part_amount
from 
samples.tpch.part p
join samples.tpch.lineitem l
on p.p_partkey = l.l_partkey
group by p.p_partkey, p.p_name
)

select * from total_revenue
order by total_part_amount
limit 3 ;

----------------------------------------------------------------------------------------------------------------------------------------------

-- with CTE and ranking
-- CTE computes totals → second CTE ranks rows → final query filters top‑N.
-- Most flexible. Supports top‑N, top‑N per group, tie handling. Industry‑standard analytics pattern. Scales to complex logic. 
-- Best for dashboards, ETL, BI.
with total_revenue as (
  select 
p.p_partkey,
p.p_name,
sum(l.l_extendedprice) as total_part_amount
from 
samples.tpch.part p
join samples.tpch.lineitem l
on p.p_partkey = l.l_partkey
group by p.p_partkey, p.p_name
),
ranked as(
  select 
  p_partkey,
  p_name,
  total_part_amount,
  row_number() over(
    partition by p_partkey,p_name
    order by total_part_amount desc
  ) as rnk
  from 
  total_revenue
)

select *
from ranked 
where 
rnk<=3
order by 4;

----------------------------------------------------------------------------------------------------------------------------------------------