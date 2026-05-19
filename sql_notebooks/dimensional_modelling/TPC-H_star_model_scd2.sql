-- Build TPC-H staging layer (STG)
-- Build the TPC-H star shcema (DIM + FACT)

-- STG :   source - samples.tpch.customer
CREATE OR REPLACE TEMP VIEW stg_customer as
select *,current_date() as effective_startdate
from 
samples.tpch.customer;

select * from stg_customer;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-- DIMENSIONS :
    -- Product Dimension - Source :samples.tpch.part
    -- Only descriptive columns. No history tracking needed.
    -- No audit columns attached.
CREATE or REPLACE TEMP VIEW dim_product AS
select 
p_partkey as product_key,
p_name as product_name,
p_mfgr as product_manufacturer,
p_brand as product_brand,
p_type as product_type,
p_size as product_size,
p_container as product_container,
p_retailprice as product_retailprice,
p_comment as product_comment
FROM
samples.tpch.part;

------------------------------------------------------------------------------------

    -- customer dimension - source : samples.tpch.customer
    -- Needs history tracking
    --auditcolumns added to maintain history.
CREATE or REPLACE TEMP VIEW dim_customer as
select 
c_custkey as customer_key,
c_name as customer_name,
c_address as customer_address,
c_nationkey as customer_nationkey,
c_phone as customer_phone,
c_acctbal as customer_accountbalance,
c_mktsegment as customer_marketsegment,
c_comment as customer_comment,
current_date() as effective_startdate,    -- load date as the effective date.
'2099-12-31' as effective_enddate,       -- setting future date a send date . Implies the record is still active.
1 as is_current                          -- 1 for active record. 0 for old record.
from 
samples.tpch.customer;

------------------------------------------------------------------------------------

    -- Date dimenson - source : samples.tpch.orders
    -- Useful for time basd analysis on orders.
CREATE Or REPLACE TEMP VIEW dim_date AS
SELECT
o_orderdate as order_date,
year(o_orderdate) as order_year,
month(o_orderdate) as order_month,
day(o_orderdate) as order_day
from
samples.tpch.orders;

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- FACT TABLE :
    -- Sales Fact - source : samples.tpch.lineitem
    -- Fact table containing revenue information.
    -- Grain = one line item per order.
    -- Joins orders and lineitems.
CREATE or REPLACE TEMP VIEW fact_sales AS
select 
l.l_orderkey as order_key,
l.l_partkey as product_key,
o.o_custkey  as customer_key,
o.o_orderdate  as order_date,
l.l_extendedprice as revenue
from 
samples.tpch.lineitem l
join samples.tpch.orders o
on l.l_orderkey = o.o_orderkey;


------------------------------------------------------------------------------------------------------------------------------------------------------

-- SCD2 logic:

-- source    : samples.tpch.customer   ( TPC-H customer master data)
-- stg       : stg_customer
-- dimension : dim_customer

MERGE into dim_customer as tgt
using (
    select *
    from stg_customer
) as src
on tgt.customer_key = src.c_custkey
and tgt.is_current=1
when matched 
AND(
    tgt.customer_name      <> src.c_name OR
    tgt.customer_nationkey <> src.c_nationkey
) THEN
UPDATE SET
    effective_enddate = current_date(),
    is_current=0
WHEN NOT MATCHED 
THEN
INSERT (
    customer_key,
    customer_name,
    customer_address,
    customer_nationkey,
    customer_phone,
    customer_accountbalance,
    customer_marketsegment,
    customer_comment,
    effective_startdate,
    effective_enddate,
    is_current
)
VALUES (
    src.c_custkey,
    src.c_name,
    src.c_address,
    src.c_nationkey,
    src.c_phone,
    src.c_acctbal,
    src.c_mktsegment,
    src.c_comment,
    current_date(),
    '2099-12-31',
    1
);

------------------------------------------------------------------------------------------------------------------------------------------------------

