{{ config(
    partition_by={
      "field": "transaction_created_date",
      "data_type": "date"
    }
)}}
with source as (
    select
        id as inventory_id,
        transaction_type,
        date(transaction_created_date) as transaction_created_date,
        transaction_modified_date,
        product_id,
        quantity,
        purchase_order_id,
        customer_order_id,
        comments,
        current_timestamp() as insertion_timestamp,
    from {{ ref('stg_inventory_transactions') }}
),
unique_source as (
    select 
        *
        , ROW_NUMBER() OVER (PARTITION BY inventory_id ORDER BY transaction_created_date DESC) AS row_number
    from source
)
SELECT
    inventory_id,
    transaction_type,
    transaction_created_date,
    transaction_modified_date,
    product_id,
    quantity,
    purchase_order_id,
    customer_order_id,
    comments,
    insertion_timestamp
FROM unique_source
WHERE row_number = 1