with 

source as (

    select * from {{ source('google_sheets', 'db_users') }}

),

renamed as (

    select

    from source

)

select * from renamed