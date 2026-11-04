{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    order_id AS order_key,
    order_id,
    order_timestamp
FROM {{ source('ecoessentials_landing', 'order') }}