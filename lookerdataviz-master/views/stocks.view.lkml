view: stocks {
  view_label: "stocks"
  derived_table: {
    sql:
    SELECT
      'AAPL' AS Symbol, 244.60 AS current_price,  '3674' AS market_cap, 'Technology' AS  sector, 34.72 AS weekchange
    UNION ALL
    SELECT
      'NVDA' AS Symbol, 138.85 AS current_price,  '3400' AS market_cap, 'Technology' AS  sector, 99.92 AS weekchange
    UNION ALL
    SELECT
      'MSFT' AS Symbol, 408.43 AS current_price, '3036' AS market_cap, 'Technology' AS  sector, 1.40 AS weekchange
    UNION ALL
    SELECT
      'AMZN' AS Symbol, 228.68 AS current_price,  '2423' AS market_cap, 'Consumer Cyclical'  AS  sector, 36.87 AS weekchange
    UNION ALL
    SELECT
      'GOOG' AS Symbol, 186.87 AS current_price,  '2266' AS market_cap, 'Communication Services' AS  sector, 31.41 AS weekchange
    UNION ALL
    SELECT
      'META' AS Symbol, 736.67 AS current_price,  '1866' AS market_cap, 'Communication Services' AS  sector, 56.16 AS weekchange
    UNION ALL
    SELECT
      'TSLA' AS Symbol, 355.84 AS current_price,  '1144' AS market_cap, 'Consumer Cyclical'  AS  sector, 83.65 AS weekchange
    UNION ALL
    SELECT
      'WMT' AS Symbol,  104.04 AS current_price,  '835' AS market_cap, 'Consumer Defensive' AS  sector, 77.48 AS weekchange
    UNION ALL
    SELECT
      'UNH' AS Symbol,  523.51 AS current_price,  '481' AS market_cap, 'Healthcare' AS  sector, 0.47 AS weekchange
    UNION ALL
    SELECT
      'XOM' AS Symbol,  108.24 AS current_price,  '471' AS market_cap, 'Energy' AS  sector, 5.34 AS weekchange
    UNION ALL
    SELECT
      'NFLX' AS Symbol, 1058.60 AS current_price, '452' AS market_cap, 'Communication Services' AS  sector, 84.06 AS weekchange
    UNION ALL
    SELECT
      'IBM' AS Symbol,  261.28 AS current_price,  '241' AS market_cap, 'Technology' AS  sector, 42.43 AS weekchange
    UNION ALL
    SELECT
      'TMO' AS Symbol,  531.85 AS current_price,  '203' AS market_cap, 'Healthcare' AS  sector, -2.97 AS weekchange
    UNION ALL
    SELECT
      'UNP' AS Symbol,  249.22 AS current_price,  '150' AS market_cap, 'Industrials'  AS  sector,0.84 AS weekchange
    UNION ALL
    SELECT
      'LOW' AS Symbol,  251.79 AS current_price,  '142' AS market_cap, 'Consumer Cyclical'  AS  sector, 11.5 AS weekchange
    UNION ALL
    SELECT
      'NEE' AS Symbol,  68.06 AS current_price, '140' AS market_cap, 'Utilities' AS  sector, 20.23 AS weekchange
    UNION ALL
    SELECT
      'CMCSA' AS Symbol,  35.39 AS current_price, '133' AS market_cap, 'Communication Services' AS  sector, -15.05 AS weekchange
    UNION ALL
    SELECT
      'AMT' AS Symbol,  189.38 AS current_price,  '88' AS market_cap, 'Real Estate'  AS  sector, 0.52 AS weekchange
    UNION ALL
    SELECT
      'CL' AS Symbol, 86.04 AS current_price, '69' AS market_cap, 'Consumer Defensive' AS  sector, 1.69 AS weekchange
    UNION ALL
    SELECT
      'EMR' AS Symbol,  123.34 AS current_price,  '69' AS market_cap, 'Industrials'  AS  sector, 17.69 AS weekchange
    UNION ALL
    SELECT
      'KVUE' AS Symbol, 21.93 AS current_price, '42' AS market_cap, 'Consumer Defensive' AS  sector, 15.06 AS weekchange
    UNION ALL
    SELECT
      'PPG' AS Symbol,  117.75 AS current_price,  '27' AS market_cap, 'Basic Materials'  AS  sector, -16.58 AS weekchange
    UNION ALL
    SELECT
      'TECK' AS Symbol, 43.08  AS current_price, '21' AS market_cap, 'Basic Materials' AS  sector, 13.67 AS weekchange
    UNION ALL
    SELECT
      'ESS' AS Symbol,  288.37 AS current_price,  '19' AS market_cap, 'Real Estate'  AS  sector, 23.79 AS weekchange
    UNION ALL
    SELECT
      'BEN' AS Symbol,  20.53 AS current_price, '10' AS market_cap, 'Financial Services' AS  sector, -24.24 AS weekchange
      ;;
    }

  dimension: symbol {
    type: string
    sql: ${TABLE}.Symbol ;;
  }

  dimension: current_price {
    value_format: "$#,##0.00;($#,##0.00)"
    type: number
    sql: ${TABLE}.current_price ;;
  }

  dimension: market_cap {
      type: number
      sql: ${TABLE}.market_cap ;;
    }

  dimension: sector {
      type: string
      sql: ${TABLE}.sector ;;
    }

  dimension: change {
    type: number
    value_format: "0.00%"
    sql: ${TABLE}.weekchange / 100.0 ;;
  }
}
