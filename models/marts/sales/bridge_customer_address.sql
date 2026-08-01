/*
- This sql file generates a business ready customer address bridge table
- A bridge table is required because multiple customers can have multiple addresses so this table acts as a bridge that connects the
-- customer table with the address table.
- This is essential for reporting accuracy and filtering direction.
*/


WITH bridge AS (
    SELECT * FROM {{ ref('stg_customeraddress') }}
)

SELECT
    CustomerID,
    AddressID,
    AddressType,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM bridge
