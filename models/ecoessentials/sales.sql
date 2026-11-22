{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    o.order_id,
    f.order_line_id,
    d.date AS order_date,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    c.state AS customer_state,
    p.product_name,
    p.product_type,
    ca.campaign_name,
    f.quantity_sold,
    f.total_amount,
    f.discount_amount
FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('dim_order') }} o ON f.order_key = o.order_key
LEFT JOIN {{ ref('dim_customer') }} c ON f.customer_key = c.customer_key
LEFT JOIN {{ ref('dim_product') }} p ON f.product_key = p.product_key
LEFT JOIN {{ ref('dim_campaign') }} ca ON f.promotion_key = ca.campaign_key
LEFT JOIN {{ ref('dim_date') }} d ON f.date_key = d.date_key