-- PIVOT
--------

-- source : samples.tpch.lineitem
select l_quantity,l_returnflag from samples.tpch.lineitem limit 5;

select * from samples.tpch.lineitem where l_orderkey = 3640868;;

select distinct l_returnflag from samples.tpch.lineitem;

-- problem : Pivot total quantity by return flag
-- Converting return flag values to columns.
select * 
from
samples.tpch.lineitem
PIVOT(
    sum(l_quantity) as total_quantity
    for l_returnflag in ('N','A','R')
)
where l_orderkey = 3640868;

-------------------------------------------
-- source : 
CREATE OR REPLACE TABLE sales_demo AS
SELECT 'A' AS product, 'Jan' AS month, 100 AS amount UNION ALL
SELECT 'A', 'Feb', 120 UNION ALL
SELECT 'B', 'Jan', 90 UNION ALL
SELECT 'B', 'Feb', 110;

select * from sales_demo

-- problem : month wise pivoting

select 
* from 


----------------------------------------------------------------------------------------------------------------------------------------------------

-- UNPIVOT
-----------

-- source : samples.nyctaxi.trips
select * from samples.nyctaxi.trips limit 5;