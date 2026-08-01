-- This file creates a business ready customer address dim table
-- it references the stg_address table


WITH address AS (
    SELECT * FROM {{ ref('stg_address') }}
)

SELECT
    AddressID,
    AddressLine1,
    City,
    StateProvince,
    CountryRegion,
    PostalCode,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM address
