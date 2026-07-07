{{
    config(materialized='incremental',
           unique_key='EMPLOYEE_ID')
}}
select EMPLOYEE_ID,
        FIRST_NAME||LAST_NAME AS NAME,
        EMAIL,
        PHONE_NUMBER,
        HIRE_DATE,
        JOB_ID,
        SALARY,
        COMMISSION_PCT,
        MANAGER_ID,
        DEPARTMENT_ID,
        current_timestamp as load_time
from {{ref('stg_employees')}}

{% if is_incremental() %}
where load_time>=(select coalesce(max(load_time),'1990-01-01 00:00:00') from {this} )

{%endif%}