view: order_items {
  sql_table_name: `looker-private-demo.thelook.order_items` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: delivered {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  dimension_group: shipped {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: total_sale_price {
    type: sum
    sql: $[${sale_price}] ;;
    value_format: "$0.00"
  }
  measure: avg_sale_price {
    type: average
    sql: $[${sale_price}] ;;
    value_format: "$0.00"
  }
  dimension: gross_margin {
    description: "Price of an order item minus the cost of inventory"
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }
  measure: total_gross_margin {
    type: sum
    sql:  ${gross_margin} ;;
  }
  measure: avg_gross_margin {
    type: average
    sql:  ${gross_margin} ;;
  }

  measure: num_items_returned {
    type: sum
    sql: if(order_items.status) = 'returned' ;;
  }

#   measure: gross_margin_pct {
#     label: "Gross margin %"
 #    description: "Total gross margin divided by total gross revenue"
#     sql: ${total_gross_margin}/${total_gross_revenue} ;;
#   }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name
  ]
  }

}
