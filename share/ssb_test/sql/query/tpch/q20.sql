select
s_name,
s_address
from
supplier,
nation
where
s_suppkey in (
select
ps_suppkey
from
partsupp
where
ps_partkey in (
select
p_partkey
from
part
where
p_name like 'blanched%'
)
and ps_availqty > (
select
0.5 * sum(l_quantity)
from
lineitem
where
l_partkey = ps_partkey
and l_suppkey = ps_suppkey
and l_shipdate >= cast('1994-01-01' as date)
and l_shipdate < cast('1994-01-01' as date) + interval '1' year
)
)
and s_nationkey = n_nationkey
and n_name = 'EGYPT'
order by
s_name;