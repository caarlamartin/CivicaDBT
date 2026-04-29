{{ config(
materialized='incremental',
incremental_strategy='append'
) }}

with 

source as (

    select * from {{ source('postgre_db', 'products') }}
    {% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }})
    {% endif %}
),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed