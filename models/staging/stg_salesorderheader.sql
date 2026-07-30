/*
This SQL file applies 3 transformations:

1. all date columns with the clean date macro in file clean_date.sql
2. transforms decimal numbers to two decimal points for the columns containing float numbers
3. adds timestamp column showing when dbt processed this change
*/

-- CTE to highlight source
WITH source_data AS (
    SELECT * FROM {{ source('bronze_saleslt', 'salesorderheader') }}
)

-- This block uses DBT jinja to loop through each column name and assess if it is a date
-- it does this by checking if the word 'date' is the the column name
-- if this condition is true, it applies the clean date macro in file clean_date.sql
-- it then transforms decimal numbers to two decimal points for the columns containing float numbers
-- else it returns the column name
-- it also adds a timestamp column showing when dbt processed this change
SELECT
    {% for col in adapter.get_columns_in_relation(source('bronze_saleslt', 'salesorderheader')) %}
        -- checks date in column name and then applies clean date macro
        {% if 'date' in col.name | lower %}
            {{ clean_date(col.name) }} AS {{ col.name }}
            
        -- transforms decimal numbers to two decimal points in columns SubTotal, TaxAmt, Freight, TotalDue
        {% elif col.name in ('SubTotal', 'TaxAmt', 'Freight', 'TotalDue') %}
            CAST({{ col.name }} AS DECIMAL(18, 2)) AS {{ col.name }}
            
        {# 3. Leave all other columns untouched #}
        {% else %}
            {{ col.name }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %},
    CURRENT_TIMESTAMP() AS dbt_processed_at
FROM source_data