{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    campaign_id AS campaign_key,
    campaign_id,
    campaign_name,
    campaign_discount AS discount
FROM {{ source('ecoessentials_landing', 'promotional_campaign') }}

UNION ALL

SELECT
    -1 AS campaign_key,
    -1 AS campaign_id,
    'No Campaign' AS campaign_name,
    0 AS discount