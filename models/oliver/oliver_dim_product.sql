{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
product_id as product_key,
product_id,
description,
unit_price,
product_name
FROM {{ source('products_landing', 'product') }}