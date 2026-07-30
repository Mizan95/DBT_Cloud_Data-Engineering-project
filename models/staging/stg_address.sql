-- This SQL file applies the transformation on the ModifiedDate column with the clean data macro in file clean_date.sql
WITH source_data AS (
    SELECT * FROM {{ source('bronze_saleslt', 'address') }}
)

SELECT
    AddressID,
    AddressLine1,
    AddressLine2,
    City,
    StateProvince,
    CountryRegion,
    PostalCode,
    -- Apply your centralized date macro seamlessly
    {{ clean_date('ModifiedDate') }} AS ModifiedDate,
    -- Add an auditing timestamp for tracking processing latency
    CURRENT_TIMESTAMP() AS dbt_processed_at

FROM source_data
