view: transactionvsweatherday {
  derived_table: {
    sql:
    SELECT
    "2025-03-21" AS Data, null AS Media_temperatura, 798 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-20" AS Data, null AS Media_temperatura, 891 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-19" AS Data, null AS Media_temperatura, 1949 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-18" AS Data, 13.7 AS Media_temperatura, 1384 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-17" AS Data, 14.0 AS Media_temperatura, 1726 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-16" AS Data, 13.6 AS Media_temperatura, 1834 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-15" AS Data, 13.3 AS Media_temperatura, 1673 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-14" AS Data, 11.9 AS Media_temperatura, 1809 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-13" AS Data, 12.1 AS Media_temperatura, 1570 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-12" AS Data, 11.4 AS Media_temperatura, 1756 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-11" AS Data, 15.6 AS Media_temperatura, 1502 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-10" AS Data, 20.8 AS Media_temperatura, 1806 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-09" AS Data, 22.2 AS Media_temperatura, 3143 AS  Venda_total_loja
    UNION ALL
    SELECT
    "2025-03-08" AS Data, 18.5 AS Media_temperatura, 2302 AS  Venda_total_loja
    ;;
  }

  dimension_group: data_transacao {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      hour_of_day,
      week,
      month,
      quarter,
      year,
      week_of_year,
      month_num
    ]
    sql: ${TABLE}.Data ;;
  }

  dimension: temperatura {
    type: number
    sql: ${TABLE}.Media_temperatura ;;
  }

  dimension: venda_total_loja {
    type: number
    sql: ${TABLE}.Venda_total_loja ;;

  }

  measure: total_venda {
    type: median
    value_format_name: usd_0
    sql: ${venda_total_loja};;
  }

  measure: media_temperatura {
    type: median
    value_format: "#,##0.0 \" °C\""
    sql: ${temperatura};;
  }
}
