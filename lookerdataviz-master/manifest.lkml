project_name: "tre-to"

visualization: {
  id: "stock_sector_heatmap"
  label: "Stock Sector Heatmap"
  file: "visualizations/stock_visualization.js"
}

visualization: {
  id: "man_pictorial"
  label: "man pictorial"
  file: "visualizations/pictorial.js"
  dependencies: ["https://code.highcharts.com/highcharts.js"]
}

visualization: {
  id: "column_custom"
  label: "compare 2 dates"
  file: "visualizations/columncustom.js"
  dependencies: ["https://code.highcharts.com/highcharts.js"]
}


visualization: {
  id: "heatmap_floorplan"
  label: "heatmap_floorplan"
  file: "visualizations/officemap.js"
  dependencies: ["https://code.highcharts.com/highcharts.js", "https://code.highcharts.com/modules/heatmap.js"]
}

application: kitchen {
  label: "pompeu kitchen React/TypeScript extension"
  url: "https://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    use_form_submit: yes
    use_embeds: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look", "dashboard" ,"dashboard_dashboard_elements","all_dashboards","all_lookml_models"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com"]

    }

}
