view: office {
  derived_table: {
    sql:
    SELECT
      1 AS x, 1 AS y, 80 AS  valor
    UNION ALL
    SELECT
      1 AS x, 2 AS y, 34 AS  valor
    UNION ALL
    SELECT
      2 AS x, 1 AS y, 25 AS  valor
    UNION ALL
    SELECT
      2 AS x, 2 AS y, 70 AS  valor
            ;;
  }
  dimension: x {
    type: number
    sql: ${TABLE}.x ;;
  }

  dimension: y {
    type: number
    sql: ${TABLE}.y ;;
  }

  dimension: valor_d {
    type: string
    sql: ${TABLE}.valor ;;
  }

  measure: valor {
    type: average
    sql: ${valor_d} ;;
  }

}
