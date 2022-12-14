--Q3.4
SELECT
    C_CITY,
    S_CITY,
    year(LO_ORDERDATE) AS year,
    sum(LO_REVENUE) AS revenue
FROM lineorder_flat
WHERE C_CITY in ('UNITED KI1', 'UNITED KI5') AND S_CITY in ( 'UNITED KI1',  'UNITED KI5') AND  LO_ORDERDATE  >= 19971201 AND LO_ORDERDATE <= 19971231
GROUP BY
    C_CITY,
    S_CITY,
    year
ORDER BY
    year ASC,
    revenue DESC;
