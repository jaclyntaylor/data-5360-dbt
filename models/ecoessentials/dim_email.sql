{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    emailid AS email_key,
    emailid AS email_id,
    MAX(emailname) AS email_name
FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}
GROUP BY emailid