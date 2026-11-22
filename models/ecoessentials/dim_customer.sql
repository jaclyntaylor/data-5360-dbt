{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

WITH subscribers AS (
    SELECT
        TRY_TO_NUMBER(customerid) AS customer_id,
        MAX(subscriberid) AS subscriber_id
    FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}
    WHERE TRY_TO_NUMBER(customerid) IS NOT NULL
    GROUP BY TRY_TO_NUMBER(customerid)
)

SELECT
    c.customer_id AS customer_key,
    c.customer_id,
    s.subscriber_id,
    c.customer_first_name AS first_name,
    c.customer_last_name AS last_name,
    c.customer_email AS email,
    c.customer_address AS address,
    c.customer_state AS state,
    c.customer_zip AS zipcode,
    c.customer_phone AS phone
FROM {{ source('ecoessentials_landing', 'customer') }} c
LEFT JOIN subscribers s
    ON c.customer_id = s.customer_id