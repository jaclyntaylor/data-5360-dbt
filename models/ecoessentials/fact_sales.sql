{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    o.order_key,
    d.date_key,
    cu.customer_key,
    p.product_key,
    COALESCE(ca.campaign_key, -1) AS promotion_key,
    ol.order_line_id,
    ol.quantity AS quantity_sold,
    ol.quantity * ol.price_after_discount AS total_amount,
    (ol.quantity * p.price) - (ol.quantity * ol.price_after_discount) AS discount_amount
FROM {{ source('ecoessentials_landing', 'order_line') }} ol
INNER JOIN {{ source('ecoessentials_landing', 'order') }} src_o
    ON ol.order_id = src_o.order_id
INNER JOIN {{ ref('dim_order') }} o
    ON src_o.order_id = o.order_id
INNER JOIN {{ ref('dim_customer') }} cu
    ON src_o.customer_id = cu.customer_id
INNER JOIN {{ ref('dim_product') }} p
    ON ol.product_id = p.product_id
LEFT JOIN {{ ref('dim_campaign') }} ca
    ON ol.campaign_id = ca.campaign_id
INNER JOIN {{ ref('dim_date') }} d
    ON d.date = CAST(src_o.order_timestamp AS DATE)
