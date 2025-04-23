view: customviz {
  derived_table: {
    sql:
    SELECT
      "France" AS Categoria, 400 AS Valor, 'Europa' AS  origem
    UNION ALL
    SELECT
      'Italy' AS Categoria, 300 AS Valor, 'Europa' AS  origem
    UNION ALL
    SELECT
      "Brazil" AS Categoria, 600 AS Valor, 'Europa' AS  origem
    UNION ALL
    SELECT
      'USA' AS Categoria, 500 AS Valor, 'Europa' AS  origem
    UNION ALL
    SELECT
      'Chile' AS Categoria, 200 AS Valor, 'Europa' AS  origem
            ;;
  }
  dimension: Categoria {
    type: string
    sql: ${TABLE}.Categoria ;;
  }

  dimension: Valor {
    type: number
    sql: ${TABLE}.Valor ;;
  }

  dimension: origem {
    type: string
    sql: ${TABLE}.origem ;;
  }

}
