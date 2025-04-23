view: MapaShopping{
  derived_table: {
    sql:
              SELECT
                'Caedu' AS Nome, '103' AS store_id, 1 AS floor, 106767 AS sales, NULL AS store_image, 53290 AS rent, 274 AS nb_of_customer, 20230701 AS date, 'Very unsatisfied' as score
              UNION ALL
              SELECT
                'Bradesco' AS Nome, '102-2' AS store_id, 1 AS floor, 370486 AS sales, NULL AS store_image, 17122 AS rent, 1341 AS nb_of_customer, 20230701 AS date, 'Unsatisfied' as score
              UNION ALL
              SELECT
                'Drogaria São Paulo' AS Nome, '102' AS store_id, 1 AS floor, 441232 AS sales, NULL AS store_image, 69020 AS rent, 22 AS nb_of_customer, 20230701 AS date, 'Neutral' as score
              UNION ALL
              SELECT
                'Magazine Luiza' AS Nome, '101' AS store_id, 1 AS floor, 962930 AS sales, NULL AS store_image, 66376 AS rent, 627 AS nb_of_customer, 20230701 AS date, 'Satisfied' as score
              UNION ALL
              SELECT
                'Casas Bahia' AS name, '113-1' AS store_id, 1 AS floor, 449047 AS sales, "Casas_Bahia.png" AS store_image, 4684 AS rent, 489 AS nb_of_customer, 20230801 AS date, 'Very satisfied' as score
              UNION ALL
              SELECT
                'Pão de açucar' AS name, 'S02' AS store_id, 1 AS floor, 29496 AS sales, NULL AS store_image, 32991 AS rent, 93 AS nb_of_customer, 20230802 AS date, 'Satisfied' as score
              UNION ALL
              SELECT
                'Habibs' AS name, 'S01' AS store_id, 1 AS floor, 61552 AS sales, NULL AS store_image, 64995 AS rent, 130 AS nb_of_customer, 20230802 AS date, 'Unsatisfied' as score
                ;;
  }

  parameter: metrics_selector {
    type: unquoted
    allowed_value: {
      value: "sales"
    }
    allowed_value: {
      value: "rent"
    }
    allowed_value: {
      value: "nb_of_customer"
    }
    allowed_value: {
      value: "sales_per_customer"
    }
    default_value: "sales"
  }

  dimension: score {
    group_label: "Rating"
    label: "Customer Satisfaction Rating"
    type: string
    sql: ${TABLE}.score;;
    html:
    {% if value == 'Very unsatisfied' %}
    <div style="background: #FBB555; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Unsatisfied' %}
        <div style="background: #FBB555; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Neutral' %}
    <div style="background: #c9daf2; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Satisfied' %}
    <div style="background: #8BC34A; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Very satisfied' %}
    <div style="background:  #8BC34A; border-radius: 2px; color: #fff; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% endif %} ;;
  }




  dimension: name_maps {
    type: string
    sql: ${TABLE}.Nome ;;
    map_layer_name: shopping_layout
    label: "nome_maps"
    html:
      <div style="margin:1em 6em 1em 1em;">
          <div style="display: inline-block; text-align: center; float:left;">
              <img src="https://github.com/kelvinPompeu/demo-looker/blob/master/Images/{{store_image._value}}?raw=true"  style="width: 50px; margin-right: 1em;">
          </div>
          <div style="display: inline-block;">
              Nome Loja: {{value}} <br>
              Andar: {{floor._value}} <br>
              Número de Clientes: {{nb_of_customer._value}} <br>
              Vendas: {{total_sales._value}} <br>
              <a href="/explore/tre-to/MapaShopping?fields=MapaShopping.name,MapaShopping.floor,MapaShopping.total_sales,MapaShopping.total_rent&f[MapaShopping.name]={{value}}">Historico</a>
          </div>
      </div>
    ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Nome ;;
    label: "nome"
    }

  dimension: actions {
    group_label: "Actions"
    description: "Various actions you can take on anomalies"
    sql: "Actions..." ;;
    action: {
      label: "Chamado - Financeiro"
      url: "https://hooks.zapier.com/hooks/catch/xxxxx/xxxxx/" #add you webhook URL here
      icon_url: "http://www.google.com/s2/favicons?domain=www.gmail.com"

      form_param: {
        name: "Mensagem"
        type: textarea
        default: " Email Referente a Loja: {{name._rendered_value}}."
        }

      form_param: {
        name: "ID Usuário Para Abertura do Chamado "
        type: string
        default: "{{ _user_attributes['email'] }}"
        required: yes
      }

      form_param: {
        name: "Severidade"
        type: select
        default: "Baixa"
        option: {
          name: "Baixa"
          label: "Baixa"
        }
        option: {
          name: "Média"
          label: "Média"
        }
        option: {
          name: "Alta"
          label: "Alta"
        }
      }
    }
  }

  dimension: History {
    sql: ${TABLE}.Nome ;;
    html: <a href="/explore/tre-to/MapaShopping?fields=MapaShopping.name,MapaShopping.floor,MapaShopping.total_sales,MapaShopping.total_rent&f[MapaShopping.name]={{value}}">Historico</a>;;
    }

  dimension: store_image {
    type: string
    sql: ${TABLE}.store_image ;;
  }

  dimension: date {
    type: date
    sql: PARSE_DATE('%Y%m%d', CAST(${TABLE}.date AS STRING)) ;;
    datatype: date
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
    html:
    <span>{{value}}</span>
    <span>Metrics:
    {% if metrics_selector._parameter_value == 'sales' %}
         Sales: {{ dt_floor_sales.demo_floor_sales_total_sales._rendered_value }}
         {% elsif metrics_selector._parameter_value == 'rent' %}
         Rent: {{ dt_floor_sales.demo_floor_sales_total_rent._rendered_value }}
         {% elsif metrics_selector._parameter_value == 'nb_of_customer' %}
         Number of Customer: {{ dt_floor_sales.demo_floor_sales_total_customer._rendered_value }}
         {% elsif metrics_selector._parameter_value == 'sales_per_customer' %}
         Sales per Customer: {{ dt_floor_sales.demo_floor_sales_sales_per_customer._rendered_value }}
    {% endif %}
     </span>
    <img src="https://storage.googleapis.com/custom_map/{{value}}.png" height="170" width="255">
    ;;
  }

  dimension: store_id_no_image {
    type: string
    sql: ${store_id} ;;
  }

  dimension: sales {
    hidden: yes
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: floor {
    type: number
    sql: ${TABLE}.floor ;;
  }

  dimension: rent {
    hidden: yes
    type: number
    sql: ${TABLE}.rent ;;
  }

  dimension: nb_of_customer {
    hidden: yes
    type: number
    sql: ${TABLE}.nb_of_customer ;;
  }

  measure: count {
    type: count
  }

  measure: total_sales {
    type: sum
    sql: ${sales} ;;
    value_format_name: decimal_0
    drill_fields: [store_id_no_image,floor,total_sales]
  }

  measure: total_rent {
    type: sum
    value_format_name: decimal_0
    sql: ${rent} ;;
  }

  measure: total_customer {
    type: sum
    value_format_name: decimal_0
    sql: ${nb_of_customer} ;;
  }

  measure: sales_per_customer {
    type: number
    value_format_name: decimal_1
    sql: SAFE_DIVIDE(${total_sales},${total_customer})　;;
  }
}
