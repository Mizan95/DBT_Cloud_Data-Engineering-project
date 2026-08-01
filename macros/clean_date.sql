{% macro clean_date(column_name) %}
    CAST(TO_DATE(FROM_UTC_TIMESTAMP(CAST({{ column_name }} AS TIMESTAMP), 'UTC')) AS DATE)
{% endmacro %}
