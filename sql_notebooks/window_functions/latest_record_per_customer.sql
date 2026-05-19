-- source  : samples.tpch.orders
-- columns : o_custkey,o_orderdate

select * 
from(
  select 
  o_orderkey,
  o_custkey,
  o_orderdate,
  o_totalprice,
row_number() over (
  partition by o_custkey     -- window per customer.
  order by o_orderdate desc  -- window per customer.
  ) as rn                    -- ROW_NUMBER() assigns 1 to the latest row
from samples.tpch.orders
)
where rn=1;                  -- filter rn = 1



