CREATE TABLE call_center (
    cc_call_center_sk BIGINT NOT NULL,
    cc_call_center_id CHAR (16) NOT NULL,
    cc_rec_start_date date NULL DEFAULT NULL,
    cc_rec_end_date date NULL DEFAULT NULL,
    cc_closed_date_sk BIGINT NULL DEFAULT NULL,
    cc_open_date_sk BIGINT NULL DEFAULT NULL,
    cc_name VARCHAR (50) NULL DEFAULT NULL,
    cc_class VARCHAR (50) NULL DEFAULT NULL,
    cc_employees BIGINT NULL DEFAULT NULL,
    cc_sq_ft BIGINT NULL DEFAULT NULL,
    cc_hours CHAR (20) NULL DEFAULT NULL,
    cc_manager VARCHAR (40) NULL DEFAULT NULL,
    cc_mkt_id BIGINT NULL DEFAULT NULL,
    cc_mkt_class CHAR (50) NULL DEFAULT NULL,
    cc_mkt_desc VARCHAR (100) NULL DEFAULT NULL,
    cc_market_manager VARCHAR (40) NULL DEFAULT NULL,
    cc_division BIGINT NULL DEFAULT NULL,
    cc_division_name VARCHAR (50) NULL DEFAULT NULL,
    cc_company BIGINT NULL DEFAULT NULL,
    cc_company_name CHAR (50) NULL DEFAULT NULL,
    cc_street_number CHAR (10) NULL DEFAULT NULL,
    cc_street_name VARCHAR (60) NULL DEFAULT NULL,
    cc_street_type CHAR (15) NULL DEFAULT NULL,
    cc_suite_number CHAR (10) NULL DEFAULT NULL,
    cc_city VARCHAR (60) NULL DEFAULT NULL,
    cc_county VARCHAR (30) NULL DEFAULT NULL,
    cc_state CHAR (2) NULL DEFAULT NULL,
    cc_zip CHAR (10) NULL DEFAULT NULL,
    cc_country VARCHAR (20) NULL DEFAULT NULL,
    cc_gmt_offset DECIMAL (5, 2) NULL DEFAULT NULL,
    cc_tax_percentage DECIMAL (5, 2) NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(cc_call_center_sk)
DISTRIBUTED BY HASH(cc_call_center_sk) BUCKETS 10
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE catalog_page (
    cp_catalog_page_sk BIGINT NOT NULL,
    cp_catalog_page_id CHAR (16) NOT NULL,
    cp_start_date_sk BIGINT NULL DEFAULT NULL,
    cp_end_date_sk BIGINT NULL DEFAULT NULL,
    cp_department VARCHAR (50) NULL DEFAULT NULL,
    cp_catalog_number BIGINT NULL DEFAULT NULL,
    cp_catalog_page_number BIGINT NULL DEFAULT NULL,
    cp_description VARCHAR (100) NULL DEFAULT NULL,
    cp_type VARCHAR (100) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(cp_catalog_page_sk)
DISTRIBUTED BY HASH(cp_catalog_page_sk) BUCKETS 10 
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE catalog_returns (
    cr_item_sk BIGINT NOT NULL,
    cr_order_number BIGINT NOT NULL,
    cr_returned_date_sk BIGINT NULL DEFAULT NULL,
    cr_returned_time_sk BIGINT NULL DEFAULT NULL,
    cr_refunded_customer_sk BIGINT NULL DEFAULT NULL,
    cr_refunded_cdemo_sk BIGINT NULL DEFAULT NULL,
    cr_refunded_hdemo_sk BIGINT NULL DEFAULT NULL,
    cr_refunded_addr_sk BIGINT NULL DEFAULT NULL,
    cr_returning_customer_sk BIGINT NULL DEFAULT NULL,
    cr_returning_cdemo_sk BIGINT NULL DEFAULT NULL,
    cr_returning_hdemo_sk BIGINT NULL DEFAULT NULL,
    cr_returning_addr_sk BIGINT NULL DEFAULT NULL,
    cr_call_center_sk BIGINT NULL DEFAULT NULL,
    cr_catalog_page_sk BIGINT NULL DEFAULT NULL,
    cr_ship_mode_sk BIGINT NULL DEFAULT NULL,
    cr_warehouse_sk BIGINT NULL DEFAULT NULL,
    cr_reason_sk BIGINT NULL DEFAULT NULL,
    cr_return_quantity BIGINT NULL DEFAULT NULL,
    cr_return_amount DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_return_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_return_amt_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_fee DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_return_ship_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_refunded_cash DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_reversed_charge DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_store_credit DECIMAL (7, 2) NULL DEFAULT NULL,
    cr_net_loss DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(cr_item_sk, cr_order_number)
DISTRIBUTED BY HASH(cr_item_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE catalog_sales (
    cs_item_sk BIGINT NOT NULL,
    cs_order_number BIGINT NOT NULL,
    cs_sold_date_sk BIGINT NULL DEFAULT NULL,
    cs_sold_time_sk BIGINT NULL DEFAULT NULL,
    cs_ship_date_sk BIGINT NULL DEFAULT NULL,
    cs_bill_customer_sk BIGINT NULL DEFAULT NULL,
    cs_bill_cdemo_sk BIGINT NULL DEFAULT NULL,
    cs_bill_hdemo_sk BIGINT NULL DEFAULT NULL,
    cs_bill_addr_sk BIGINT NULL DEFAULT NULL,
    cs_ship_customer_sk BIGINT NULL DEFAULT NULL,
    cs_ship_cdemo_sk BIGINT NULL DEFAULT NULL,
    cs_ship_hdemo_sk BIGINT NULL DEFAULT NULL,
    cs_ship_addr_sk BIGINT NULL DEFAULT NULL,
    cs_call_center_sk BIGINT NULL DEFAULT NULL,
    cs_catalog_page_sk BIGINT NULL DEFAULT NULL,
    cs_ship_mode_sk BIGINT NULL DEFAULT NULL,
    cs_warehouse_sk BIGINT NULL DEFAULT NULL,
    cs_promo_sk BIGINT NULL DEFAULT NULL,
    cs_quantity BIGINT NULL DEFAULT NULL,
    cs_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_discount_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_coupon_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_ext_ship_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_net_paid DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_net_paid_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_net_paid_inc_ship DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_net_paid_inc_ship_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    cs_net_profit DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(cs_item_sk, cs_order_number)
DISTRIBUTED BY HASH(cs_item_sk) BUCKETS 100 
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE customer_address (
    ca_address_sk BIGINT NOT NULL,
    ca_address_id CHAR (16) NOT NULL,
    ca_street_number CHAR (10) NULL DEFAULT NULL,
    ca_street_name VARCHAR (60) NULL DEFAULT NULL,
    ca_street_type CHAR (15) NULL DEFAULT NULL,
    ca_suite_number CHAR (10) NULL DEFAULT NULL,
    ca_city VARCHAR (60) NULL DEFAULT NULL,
    ca_county VARCHAR (30) NULL DEFAULT NULL,
    ca_state CHAR (2) NULL DEFAULT NULL,
    ca_zip CHAR (10) NULL DEFAULT NULL,
    ca_country VARCHAR (20) NULL DEFAULT NULL,
    ca_gmt_offset DECIMAL (5, 2) NULL DEFAULT NULL,
    ca_location_type CHAR (20) NULL DEFAULT NULL
)
ENGINE = olap
DUPLICATE KEY(ca_address_sk)
DISTRIBUTED BY HASH(ca_address_sk) BUCKETS 100
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE customer_demographics (
    cd_demo_sk BIGINT NOT NULL,
    cd_gender CHAR (1) NULL DEFAULT NULL,
    cd_marital_status CHAR (1) NULL DEFAULT NULL,
    cd_education_status CHAR (20) NULL DEFAULT NULL,
    cd_purchase_estimate BIGINT NULL DEFAULT NULL,
    cd_credit_rating CHAR (10) NULL DEFAULT NULL,
    cd_dep_count BIGINT NULL DEFAULT NULL,
    cd_dep_employed_count BIGINT NULL DEFAULT NULL,
    cd_dep_college_count BIGINT NULL DEFAULT NULL
)
ENGINE = olap
DUPLICATE KEY(cd_demo_sk)
DISTRIBUTED BY HASH(cd_demo_sk) BUCKETS 10
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE customer (
    c_customer_sk BIGINT NOT NULL,
    c_customer_id CHAR (16) NOT NULL,
    c_current_cdemo_sk BIGINT NULL DEFAULT NULL,
    c_current_hdemo_sk BIGINT NULL DEFAULT NULL,
    c_current_addr_sk BIGINT NULL DEFAULT NULL,
    c_first_shipto_date_sk BIGINT NULL DEFAULT NULL,
    c_first_sales_date_sk BIGINT NULL DEFAULT NULL,
    c_salutation CHAR (10) NULL DEFAULT NULL,
    c_first_name CHAR (20) NULL DEFAULT NULL,
    c_last_name CHAR (30) NULL DEFAULT NULL,
    c_preferred_cust_flag CHAR (1) NULL DEFAULT NULL,
    c_birth_day BIGINT NULL DEFAULT NULL,
    c_birth_month BIGINT NULL DEFAULT NULL,
    c_birth_year BIGINT NULL DEFAULT NULL,
    c_birth_country VARCHAR (20) NULL DEFAULT NULL,
    c_login CHAR (13) NULL DEFAULT NULL,
    c_email_address CHAR (50) NULL DEFAULT NULL,
    c_last_review_date CHAR (10) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(c_customer_sk)
DISTRIBUTED BY HASH(c_customer_sk) BUCKETS 10 
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE date_dim (
    d_date_sk BIGINT NOT NULL,
    d_date_id CHAR (16) NOT NULL,
    d_date date NULL DEFAULT NULL,
    d_month_seq BIGINT NULL DEFAULT NULL,
    d_week_seq BIGINT NULL DEFAULT NULL,
    d_quarter_seq BIGINT NULL DEFAULT NULL,
    d_year BIGINT NULL DEFAULT NULL,
    d_dow BIGINT NULL DEFAULT NULL,
    d_moy BIGINT NULL DEFAULT NULL,
    d_dom BIGINT NULL DEFAULT NULL,
    d_qoy BIGINT NULL DEFAULT NULL,
    d_fy_year BIGINT NULL DEFAULT NULL,
    d_fy_quarter_seq BIGINT NULL DEFAULT NULL,
    d_fy_week_seq BIGINT NULL DEFAULT NULL,
    d_day_name CHAR (9) NULL DEFAULT NULL,
    d_quarter_name CHAR (6) NULL DEFAULT NULL,
    d_holiday CHAR (1) NULL DEFAULT NULL,
    d_weekend CHAR (1) NULL DEFAULT NULL,
    d_following_holiday CHAR (1) NULL DEFAULT NULL,
    d_first_dom BIGINT NULL DEFAULT NULL,
    d_last_dom BIGINT NULL DEFAULT NULL,
    d_same_day_ly BIGINT NULL DEFAULT NULL,
    d_same_day_lq BIGINT NULL DEFAULT NULL,
    d_current_day CHAR (1) NULL DEFAULT NULL,
    d_current_week CHAR (1) NULL DEFAULT NULL,
    d_current_month CHAR (1) NULL DEFAULT NULL,
    d_current_quarter CHAR (1) NULL DEFAULT NULL,
    d_current_year CHAR (1) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(d_date_sk)
DISTRIBUTED BY HASH(d_date_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE dbgen_version (
    dv_version VARCHAR (16) NULL DEFAULT NULL,
    dv_create_date date NULL DEFAULT NULL,
    dv_create_time VARCHAR (64) NULL DEFAULT NULL,
    dv_cmdline_args VARCHAR (200) NULL DEFAULT NULL
) 
ENGINE = olap
DISTRIBUTED BY HASH(dv_version) BUCKETS 10
PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE household_demographics (
    hd_demo_sk BIGINT NOT NULL,
    hd_income_band_sk BIGINT NULL DEFAULT NULL,
    hd_buy_potential CHAR (15) NULL DEFAULT NULL,
    hd_dep_count BIGINT NULL DEFAULT NULL,
    hd_vehicle_count BIGINT NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(hd_demo_sk) 
DISTRIBUTED BY HASH(hd_demo_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE income_band (
    ib_income_band_sk BIGINT NOT NULL,
    ib_lower_bound BIGINT NULL DEFAULT NULL,
    ib_upper_bound BIGINT NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(ib_income_band_sk)
DISTRIBUTED BY HASH(ib_income_band_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE inventory (
    inv_date_sk BIGINT NOT NULL,
    inv_item_sk BIGINT NOT NULL,
    inv_warehouse_sk BIGINT NOT NULL,
    inv_quantity_on_hand BIGINT NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(inv_date_sk, inv_item_sk, inv_warehouse_sk)
DISTRIBUTED BY HASH(inv_date_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE item (
    i_item_sk BIGINT NOT NULL,
    i_item_id CHAR (16) NOT NULL,
    i_rec_start_date date NULL DEFAULT NULL,
    i_rec_end_date date NULL DEFAULT NULL,
    i_item_desc VARCHAR (200) NULL DEFAULT NULL,
    i_current_price DECIMAL (7, 2) NULL DEFAULT NULL,
    i_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    i_brand_id BIGINT NULL DEFAULT NULL,
    i_brand CHAR (50) NULL DEFAULT NULL,
    i_class_id BIGINT NULL DEFAULT NULL,
    i_class CHAR (50) NULL DEFAULT NULL,
    i_category_id BIGINT NULL DEFAULT NULL,
    i_category CHAR (50) NULL DEFAULT NULL,
    i_manufact_id BIGINT NULL DEFAULT NULL,
    i_manufact CHAR (50) NULL DEFAULT NULL,
    i_size CHAR (20) NULL DEFAULT NULL,
    i_formulation CHAR (20) NULL DEFAULT NULL,
    i_color CHAR (20) NULL DEFAULT NULL,
    i_units CHAR (10) NULL DEFAULT NULL,
    i_container CHAR (10) NULL DEFAULT NULL,
    i_manager_id BIGINT NULL DEFAULT NULL,
    i_product_name CHAR (50) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(i_item_sk)
DISTRIBUTED BY HASH(i_item_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE promotion (
    p_promo_sk BIGINT NOT NULL,
    p_promo_id CHAR (16) NOT NULL,
    p_start_date_sk BIGINT NULL DEFAULT NULL,
    p_end_date_sk BIGINT NULL DEFAULT NULL,
    p_item_sk BIGINT NULL DEFAULT NULL,
    p_cost DECIMAL (15, 2) NULL DEFAULT NULL,
    p_response_target BIGINT NULL DEFAULT NULL,
    p_promo_name CHAR (50) NULL DEFAULT NULL,
    p_channel_dmail CHAR (1) NULL DEFAULT NULL,
    p_channel_email CHAR (1) NULL DEFAULT NULL,
    p_channel_catalog CHAR (1) NULL DEFAULT NULL,
    p_channel_tv CHAR (1) NULL DEFAULT NULL,
    p_channel_radio CHAR (1) NULL DEFAULT NULL,
    p_channel_press CHAR (1) NULL DEFAULT NULL,
    p_channel_event CHAR (1) NULL DEFAULT NULL,
    p_channel_demo CHAR (1) NULL DEFAULT NULL,
    p_channel_details VARCHAR (100) NULL DEFAULT NULL,
    p_purpose CHAR (15) NULL DEFAULT NULL,
    p_discount_active CHAR (1) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(p_promo_sk)
DISTRIBUTED BY HASH(p_promo_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE reason (
    r_reason_sk BIGINT NOT NULL,
    r_reason_id CHAR (16) NOT NULL,
    r_reason_desc CHAR (100) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(r_reason_sk)
DISTRIBUTED BY HASH(r_reason_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE ship_mode (
    sm_ship_mode_sk BIGINT NOT NULL,
    sm_ship_mode_id CHAR (16) NOT NULL,
    sm_type CHAR (30) NULL DEFAULT NULL,
    sm_code CHAR (10) NULL DEFAULT NULL,
    sm_carrier CHAR (20) NULL DEFAULT NULL,
    sm_contract CHAR (20) NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(sm_ship_mode_sk)
DISTRIBUTED BY HASH(sm_ship_mode_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE store_returns (
    sr_item_sk BIGINT NOT NULL,
    sr_ticket_number BIGINT NOT NULL,
    sr_returned_date_sk BIGINT NULL DEFAULT NULL,
    sr_return_time_sk BIGINT NULL DEFAULT NULL,
    sr_customer_sk BIGINT NULL DEFAULT NULL,
    sr_cdemo_sk BIGINT NULL DEFAULT NULL,
    sr_hdemo_sk BIGINT NULL DEFAULT NULL,
    sr_addr_sk BIGINT NULL DEFAULT NULL,
    sr_store_sk BIGINT NULL DEFAULT NULL,
    sr_reason_sk BIGINT NULL DEFAULT NULL,
    sr_return_quantity BIGINT NULL DEFAULT NULL,
    sr_return_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_return_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_return_amt_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_fee DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_return_ship_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_refunded_cash DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_reversed_charge DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_store_credit DECIMAL (7, 2) NULL DEFAULT NULL,
    sr_net_loss DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(sr_item_sk, sr_ticket_number)
DISTRIBUTED BY HASH(sr_item_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE store_sales (
    ss_item_sk BIGINT NOT NULL,
    ss_ticket_number BIGINT NOT NULL,
    ss_sold_date_sk BIGINT NULL DEFAULT NULL,
    ss_sold_time_sk BIGINT NULL DEFAULT NULL,
    ss_customer_sk BIGINT NULL DEFAULT NULL,
    ss_cdemo_sk BIGINT NULL DEFAULT NULL,
    ss_hdemo_sk BIGINT NULL DEFAULT NULL,
    ss_addr_sk BIGINT NULL DEFAULT NULL,
    ss_store_sk BIGINT NULL DEFAULT NULL,
    ss_promo_sk BIGINT NULL DEFAULT NULL,
    ss_quantity BIGINT NULL DEFAULT NULL,
    ss_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_ext_discount_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_ext_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_ext_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_ext_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_ext_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_coupon_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_net_paid DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_net_paid_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    ss_net_profit DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(ss_item_sk, ss_ticket_number)
DISTRIBUTED BY HASH(ss_item_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE store (
    s_store_sk BIGINT NOT NULL,
    s_store_id CHAR (16) NOT NULL,
    s_rec_start_date date NULL DEFAULT NULL,
    s_rec_end_date date NULL DEFAULT NULL,
    s_closed_date_sk BIGINT NULL DEFAULT NULL,
    s_store_name VARCHAR (50) NULL DEFAULT NULL,
    s_number_employees BIGINT NULL DEFAULT NULL,
    s_floor_space BIGINT NULL DEFAULT NULL,
    s_hours CHAR (20) NULL DEFAULT NULL,
    s_manager VARCHAR (40) NULL DEFAULT NULL,
    s_market_id BIGINT NULL DEFAULT NULL,
    s_geography_class VARCHAR (100) NULL DEFAULT NULL,
    s_market_desc VARCHAR (100) NULL DEFAULT NULL,
    s_market_manager VARCHAR (40) NULL DEFAULT NULL,
    s_division_id BIGINT NULL DEFAULT NULL,
    s_division_name VARCHAR (50) NULL DEFAULT NULL,
    s_company_id BIGINT NULL DEFAULT NULL,
    s_company_name VARCHAR (50) NULL DEFAULT NULL,
    s_street_number VARCHAR (10) NULL DEFAULT NULL,
    s_street_name VARCHAR (60) NULL DEFAULT NULL,
    s_street_type CHAR (15) NULL DEFAULT NULL,
    s_suite_number CHAR (10) NULL DEFAULT NULL,
    s_city VARCHAR (60) NULL DEFAULT NULL,
    s_county VARCHAR (30) NULL DEFAULT NULL,
    s_state CHAR (2) NULL DEFAULT NULL,
    s_zip CHAR (10) NULL DEFAULT NULL,
    s_country VARCHAR (20) NULL DEFAULT NULL,
    s_gmt_offset DECIMAL (5, 2) NULL DEFAULT NULL,
    s_tax_precentage DECIMAL (5, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(s_store_sk)
DISTRIBUTED BY HASH(s_store_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE time_dim (
    t_time_sk BIGINT NOT NULL,
    t_time_id CHAR (16) NOT NULL,
    t_time BIGINT NULL DEFAULT NULL,
    t_hour BIGINT NULL DEFAULT NULL,
    t_minute BIGINT NULL DEFAULT NULL,
    t_second BIGINT NULL DEFAULT NULL,
    t_am_pm CHAR (2) NULL DEFAULT NULL,
    t_shift CHAR (20) NULL DEFAULT NULL,
    t_sub_shift CHAR (20) NULL DEFAULT NULL,
    t_meal_time CHAR (20) NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(t_time_sk) 
DISTRIBUTED BY HASH(t_time_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE warehouse (
    w_warehouse_sk BIGINT NOT NULL,
    w_warehouse_id CHAR (16) NOT NULL,
    w_warehouse_name VARCHAR (20) NULL DEFAULT NULL,
    w_warehouse_sq_ft BIGINT NULL DEFAULT NULL,
    w_street_number CHAR (10) NULL DEFAULT NULL,
    w_street_name VARCHAR (60) NULL DEFAULT NULL,
    w_street_type CHAR (15) NULL DEFAULT NULL,
    w_suite_number CHAR (10) NULL DEFAULT NULL,
    w_city VARCHAR (60) NULL DEFAULT NULL,
    w_county VARCHAR (30) NULL DEFAULT NULL,
    w_state CHAR (2) NULL DEFAULT NULL,
    w_zip CHAR (10) NULL DEFAULT NULL,
    w_country VARCHAR (20) NULL DEFAULT NULL,
    w_gmt_offset DECIMAL (5, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(w_warehouse_sk)
DISTRIBUTED BY HASH(w_warehouse_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE web_page (
    wp_web_page_sk BIGINT NOT NULL,
    wp_web_page_id CHAR (16) NOT NULL,
    wp_rec_start_date date NULL DEFAULT NULL,
    wp_rec_end_date date NULL DEFAULT NULL,
    wp_creation_date_sk BIGINT NULL DEFAULT NULL,
    wp_access_date_sk BIGINT NULL DEFAULT NULL,
    wp_autogen_flag CHAR (1) NULL DEFAULT NULL,
    wp_customer_sk BIGINT NULL DEFAULT NULL,
    wp_url VARCHAR (100) NULL DEFAULT NULL,
    wp_type CHAR (50) NULL DEFAULT NULL,
    wp_char_count BIGINT NULL DEFAULT NULL,
    wp_link_count BIGINT NULL DEFAULT NULL,
    wp_image_count BIGINT NULL DEFAULT NULL,
    wp_max_ad_count BIGINT NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(wp_web_page_sk)
DISTRIBUTED BY HASH(wp_web_page_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE web_returns (
    wr_item_sk BIGINT NOT NULL,
    wr_order_number BIGINT NOT NULL,
    wr_returned_date_sk BIGINT NULL DEFAULT NULL,
    wr_returned_time_sk BIGINT NULL DEFAULT NULL,
    wr_refunded_customer_sk BIGINT NULL DEFAULT NULL,
    wr_refunded_cdemo_sk BIGINT NULL DEFAULT NULL,
    wr_refunded_hdemo_sk BIGINT NULL DEFAULT NULL,
    wr_refunded_addr_sk BIGINT NULL DEFAULT NULL,
    wr_returning_customer_sk BIGINT NULL DEFAULT NULL,
    wr_returning_cdemo_sk BIGINT NULL DEFAULT NULL,
    wr_returning_hdemo_sk BIGINT NULL DEFAULT NULL,
    wr_returning_addr_sk BIGINT NULL DEFAULT NULL,
    wr_web_page_sk BIGINT NULL DEFAULT NULL,
    wr_reason_sk BIGINT NULL DEFAULT NULL,
    wr_return_quantity BIGINT NULL DEFAULT NULL,
    wr_return_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_return_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_return_amt_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_fee DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_return_ship_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_refunded_cash DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_reversed_charge DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_account_credit DECIMAL (7, 2) NULL DEFAULT NULL,
    wr_net_loss DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap
DUPLICATE KEY(wr_item_sk, wr_order_number)
distributed BY HASH(wr_item_sk) buckets 100 properties ("storage_type" = "column","replication_num" = "1");

CREATE TABLE web_sales (
    ws_item_sk BIGINT NOT NULL,
    ws_order_number BIGINT NOT NULL,
    ws_sold_date_sk BIGINT NULL DEFAULT NULL,
    ws_sold_time_sk BIGINT NULL DEFAULT NULL,
    ws_ship_date_sk BIGINT NULL DEFAULT NULL,
    ws_bill_customer_sk BIGINT NULL DEFAULT NULL,
    ws_bill_cdemo_sk BIGINT NULL DEFAULT NULL,
    ws_bill_hdemo_sk BIGINT NULL DEFAULT NULL,
    ws_bill_addr_sk BIGINT NULL DEFAULT NULL,
    ws_ship_customer_sk BIGINT NULL DEFAULT NULL,
    ws_ship_cdemo_sk BIGINT NULL DEFAULT NULL,
    ws_ship_hdemo_sk BIGINT NULL DEFAULT NULL,
    ws_ship_addr_sk BIGINT NULL DEFAULT NULL,
    ws_web_page_sk BIGINT NULL DEFAULT NULL,
    ws_web_site_sk BIGINT NULL DEFAULT NULL,
    ws_ship_mode_sk BIGINT NULL DEFAULT NULL,
    ws_warehouse_sk BIGINT NULL DEFAULT NULL,
    ws_promo_sk BIGINT NULL DEFAULT NULL,
    ws_quantity BIGINT NULL DEFAULT NULL,
    ws_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_discount_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_sales_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_wholesale_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_list_price DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_coupon_amt DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_ext_ship_cost DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_net_paid DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_net_paid_inc_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_net_paid_inc_ship DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_net_paid_inc_ship_tax DECIMAL (7, 2) NULL DEFAULT NULL,
    ws_net_profit DECIMAL (7, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(ws_item_sk, ws_order_number)
DISTRIBUTED BY HASH(ws_item_sk) BUCKETS 100 PROPERTIES ("storage_type" = "column","replication_num" = "1");

CREATE TABLE web_site (
    web_site_sk BIGINT NOT NULL,
    web_site_id CHAR (16) NOT NULL,
    web_rec_start_date date NULL DEFAULT NULL,
    web_rec_end_date date NULL DEFAULT NULL,
    web_name VARCHAR (50) NULL DEFAULT NULL,
    web_open_date_sk BIGINT NULL DEFAULT NULL,
    web_close_date_sk BIGINT NULL DEFAULT NULL,
    web_class VARCHAR (50) NULL DEFAULT NULL,
    web_manager VARCHAR (40) NULL DEFAULT NULL,
    web_mkt_id BIGINT NULL DEFAULT NULL,
    web_mkt_class VARCHAR (50) NULL DEFAULT NULL,
    web_mkt_desc VARCHAR (100) NULL DEFAULT NULL,
    web_market_manager VARCHAR (40) NULL DEFAULT NULL,
    web_company_id BIGINT NULL DEFAULT NULL,
    web_company_name CHAR (50) NULL DEFAULT NULL,
    web_street_number CHAR (10) NULL DEFAULT NULL,
    web_street_name VARCHAR (60) NULL DEFAULT NULL,
    web_street_type CHAR (15) NULL DEFAULT NULL,
    web_suite_number CHAR (10) NULL DEFAULT NULL,
    web_city VARCHAR (60) NULL DEFAULT NULL,
    web_county VARCHAR (30) NULL DEFAULT NULL,
    web_state CHAR (2) NULL DEFAULT NULL,
    web_zip CHAR (10) NULL DEFAULT NULL,
    web_country VARCHAR (20) NULL DEFAULT NULL,
    web_gmt_offset DECIMAL (5, 2) NULL DEFAULT NULL,
    web_tax_percentage DECIMAL (5, 2) NULL DEFAULT NULL
) ENGINE = olap 
DUPLICATE KEY(web_site_sk)
DISTRIBUTED BY HASH(web_site_sk) BUCKETS 10 PROPERTIES ("storage_type" = "column","replication_num" = "1");
