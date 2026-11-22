{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    e.emaileventid AS email_event_id,
    cu.customer_key,
    em.email_key,
    COALESCE(ca.campaign_key, -1) AS campaign_key,
    et.event_type_key,
    d.date_key AS event_date_key,
    1 AS event_count,
    DATEDIFF('second', e.sendtimestamp, e.eventtimestamp) AS seconds_since_send
FROM {{ source('ecoessentials_marketing', 'marketing_emails') }} e
INNER JOIN {{ ref('dim_customer') }} cu
    ON TRY_TO_NUMBER(e.customerid) = cu.customer_id
INNER JOIN {{ ref('dim_email') }} em
    ON e.emailid = em.email_id
LEFT JOIN {{ ref('dim_campaign') }} ca
    ON e.campaignid = ca.campaign_id
INNER JOIN {{ ref('dim_event_type') }} et
    ON e.eventtype = et.event_type
INNER JOIN {{ ref('dim_date') }} d
    ON d.date = CAST(e.eventtimestamp AS DATE)