# Define the database connection to be used for this model.
connection: "looker-private-demo"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: tre_to_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Tre-to"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: olimpiadas {}

explore: office {}

explore: transactionvsweatherday {}

explore: customviz {}

explore: candidatos_do_tocantin {}

explore: examplodemapadeshopping {}

explore: MapaShopping {}

explore: stocks {}

map_layer: uf {
  file: "/maps/uf.json"
}

map_layer: municipio {
  file: "/maps/municipio.json"
}

map_layer: Sp {
  url: "/mapsgeojs-35-mun.json"
  feature_key: "id"
}

map_layer: pac {
  file: "/maps/pac.json"
  property_key: "Name"
  format: topojson
}

map_layer: shopping_layout {
  file: "/maps/shopping_layout.json"
  property_key: "Nome"
  }
