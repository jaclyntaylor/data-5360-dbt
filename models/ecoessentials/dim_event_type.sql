{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY eventtype) AS event_type_key,
    eventtype AS event_type
FROM (
    SELECT DISTINCT eventtype
    FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}
    WHERE eventtype IS NOT NULL
)