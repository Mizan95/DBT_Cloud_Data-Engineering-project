-- This SQL file applies the transformation on all date columns with the clean date macro in file clean_date.sql
-- CTE to highlight source
WITH source_data AS (
    SELECT * FROM {{ source('bronze_saleslt', 'productdescription') }}
)

-- This block uses DBT jinja to loop through each column name and assess if it is a date
-- it does this by checking if the word 'date' is the the column name
-- if this condition is true, it applies the clean date macro in file clean_date.sql
-- else it returns the column name
-- it also adds a timestamp column showing when dbt processed this change
SELECT
    {% for col in adapter.get_columns_in_relation(source('bronze_saleslt', 'productdescription')) %}
        {% if 'date' in col.name | lower %}
            {{ clean_date(col.name) }} AS {{ col.name }}
        {% else %}
            {{ col.name }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %},
    CURRENT_TIMESTAMP() AS dbt_processed_at
FROM source_data