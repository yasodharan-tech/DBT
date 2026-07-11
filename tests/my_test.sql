select * from {{ source("sr", "src_employees") }} 
where first_name='u'