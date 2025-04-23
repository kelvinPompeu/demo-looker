# The name of this view in Looker is "Codigo Municipio"
view: codigo_municipio {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `edp-k1-dwh-cur.edp_k1_dwh_cur_bq_0.Codigo_Municipio` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Codigo Ibge" in Explore.

  dimension: codigo_ibge {
    map_layer_name: Sp
    type: string
    value_format: "#######"
    sql: cast(${TABLE}.CODIGO_IBGE as string);;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_codigo_ibge {
    type: sum
    sql: ${codigo_ibge} ;;  }
  measure: average_codigo_ibge {
    type: average
    sql: ${codigo_ibge} ;;  }

  dimension: distrito {
    type: number
    sql: ${TABLE}.DISTRITO ;;
  }

  dimension: numero_municipio {
    type: number
    sql: ${TABLE}.MUNICIPIO ;;
  }

  dimension: nome_da_uf {
    type: string
    sql: ${TABLE}.NOME_DA_UF ;;
  }

  dimension: nome_do_distrito {
    type: string
    sql: ${TABLE}.NOME_DO_DISTRITO ;;
  }

  dimension: nome_do_municipio {
    map_layer_name: Sp
    type: string
    sql: ${TABLE}.NOME_DO_MUNICIPIO ;;
  }

  dimension: nome_do_subdistrito {
    type: string
    sql: ${TABLE}.NOME_DO_SUBDISTRITO ;;
  }

  dimension: subdistrit0 {
    type: string
    sql: ${TABLE}.SUBDISTRIT0 ;;
  }

  dimension: uf {
    type: number
    sql: ${TABLE}.UF ;;
  }
  measure: count {
    type: count
  }


}
