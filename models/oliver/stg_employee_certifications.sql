{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    *,
    parse_json(certification_json):certification_name::varchar as certification_name,
    parse_json(certification_json):certification_cost::number(10,2) as certification_cost,
    parse_json(certification_json):certification_awarded_date::date as certification_awarded_date
from {{ source('products_landing', 'employee_certifications') }}