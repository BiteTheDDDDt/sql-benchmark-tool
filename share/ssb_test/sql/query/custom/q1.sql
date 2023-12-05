select count(1) from (
select ss_customer_sk customer_sk
      ,ss_item_sk item_sk
from store_sales,date_dim
where ss_sold_date_sk = d_date_sk
  and d_month_seq between 1199 and 1199 + 11 and ss_sold_date_sk IS NOT NULL
group by ss_customer_sk
        ,ss_item_sk
) a;
