-- sources : samples.tpch.orders, samples.tpch.lineitem
-- columns : oders.o_orderkey, lineitem.l_orderkey

-- problem : Missing records. 
-- Find orders with no line items.

select 
o.*,l.l_orderkey
from samples.tpch.orders o
left join samples.tpch.lineitem l
on o.o_orderkey = l.l_orderkey
where l.l_orderkey is null