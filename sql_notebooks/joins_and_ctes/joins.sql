--sources : samples.tpch.customer, samples.tpch.orders
--columns : orders.o_custkey, customer.c_custkey

-- Inner join
-- Problem : Join Customers & Orders. Returns all orders with customer details
select 
    c.c_custkey,
    c.c_name,
    o.o_orderkey,
    o.o_orderdate,
    o.o_totalprice
from
samples.tpch.customer c
join samples.tpch.orders o
on c.c_custkey = o.o_custkey; 

----------------------------------------------------------------------------------------------------------------------------------------------

-- NULL safe joins
-- source : samples.nyctaxi.trips
-- columns : pickup_zip, dropoff_zip ( these columns can have null values)

-- Problem : Query to handee nulls during joins.

select distinct  
a.pickup_zip,
b.dropoff_zip
from 
samples.nyctaxi.trips a
join samples.nyctaxi.trips b
on coalesce(a.pickup_zip,0) = coalesce(b.dropoff_zip,0)
where a.pickup_zip is null
order by a.pickup_zip,b.dropoff_zip
-- NULL = NULL → FALSE . COALESCE(NULL, 0) → 0. So COALESCE(NULL, -1) = COALESCE(NULL, -1) → TRUE.  This allows NULLs to match each other in joins.

----------------------------------------------------------------------------------------------------------------------------------------------