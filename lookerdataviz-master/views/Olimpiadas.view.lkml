view: olimpiadas {
  derived_table: {
    sql:
    SELECT
      "ca" AS pais, 2020 AS ano, 9 AS  num_medalhas
    UNION ALL
    SELECT
      'ja' AS pais, 2020 AS ano, 12 AS  num_medalhas
    UNION ALL
    SELECT
      "au" AS pais, 2020 AS ano, 8 AS  num_medalhas
    UNION ALL
    SELECT
      'fr' AS pais, 2020 AS ano, 17 AS num_medalhas
    UNION ALL
    SELECT
      'br' AS pais, 2020 AS ano, 19 AS  num_medalhas
    UNION ALL
    SELECT
      "ch" AS pais, 2020 AS ano, 9 AS  num_medalhas
    UNION ALL
    SELECT
      'gb' AS pais, 2020 AS ano, 27 AS  num_medalhas
    UNION ALL
    SELECT
      'us' AS pais, 2020 AS ano, 46 AS  num_medalhas
    UNION ALL
    SELECT
      "ca" AS pais, 2016 AS ano, 13 AS  num_medalhas
    UNION ALL
    SELECT
      'ja' AS pais, 2016 AS ano, 7 AS  num_medalhas
    UNION ALL
    SELECT
      "au" AS pais, 2016 AS ano, 8 AS  num_medalhas
    UNION ALL
    SELECT
      'fr' AS pais, 2016 AS ano, 11 AS  num_medalhas
    UNION ALL
    SELECT
      'br' AS pais, 2016 AS ano, 20 AS  num_medalhas
    UNION ALL
    SELECT
      "ch" AS pais, 2016 AS ano, 26 AS  num_medalhas
    UNION ALL
    SELECT
      'gb' AS pais, 2016 AS ano, 29 AS  num_medalhas
    UNION ALL
    SELECT
      'us' AS pais, 2016 AS ano, 47 AS  num_medalhas
            ;;
  }
  dimension: pais {
    type: string
    sql: ${TABLE}.pais ;;
  }

  dimension: ano {
    type: number
    sql: ${TABLE}.ano ;;
  }



  dimension: num_medalhas_d {
    type: number
    sql: ${TABLE}.num_medalhas ;;
  }

  measure: num_medalhas {
    type: average
    sql: ${num_medalhas_d} ;;
  }


}
