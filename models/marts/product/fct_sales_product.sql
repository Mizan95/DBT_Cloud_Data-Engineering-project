WITH fct_sales_product AS (
    SELECT * FROM {{ ref('fct_sales') }}
)

SELECT
    -- This pulls every valid column from fct_sales without causing spelling errors
    {{ dbt_utils.star(from=ref('fct_sales')) }},
    
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM fct_sales_product