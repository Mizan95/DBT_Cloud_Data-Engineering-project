-- This file creates a business ready customer dim table
-- it references the stg_customer table

WITH customer AS (
    SELECT * FROM {{ ref('stg_customer') }}
)

SELECT
    CustomerID,
    CompanyName,
    CONCAT(COALESCE(FirstName, ''), ' ', COALESCE(LastName, '')) AS FullName, -- This concatenates the first and last name of the customer
    SalesPerson,
    EmailAddress,
    Phone,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM customer
