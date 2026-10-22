{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
customer_id as customer_key,
customer_id,
state,
email,
last_name,
phone_number,
first_name
FROM {{ source('products_landing', 'customer') }}