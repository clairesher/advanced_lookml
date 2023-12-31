connection: "looker-private-demo"
#Database: "looker-private-demo"
#Schema: "thelook"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: users {
   join: order_items {
     relationship: one_to_many
     sql_on: ${users.id} = ${order_items.user_id} ;;
   }
  join: inventory_items {
     relationship: one_to_one
     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
   }
  join: products {
    relationship: many_to_one
    sql_on: ${inventory_items.product_id} = ${products.id};;
  }
   join: distribution_centers {
     relationship: many_to_one
     sql_on:${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
   }

 }
