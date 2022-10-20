SELECT p_brand,
       p_type,
       p_size,
       Count(DISTINCT ps_suppkey) AS supplier_cnt
FROM   partsupp,
       part
WHERE  p_partkey = ps_partkey
       AND p_brand <> 'Brand#54'
       AND p_type NOT LIKE 'LARGE BURNISHED%'
       AND p_size IN ( 3, 5, 15, 13,
                       28, 16, 43, 50 )
       AND ps_suppkey NOT IN (SELECT s_suppkey
                              FROM   supplier
                              WHERE  s_comment LIKE '%Customer%Complaints%')
GROUP  BY p_brand,
          p_type,
          p_size
ORDER  BY supplier_cnt DESC,
          p_brand,
          p_type,
          p_size; 