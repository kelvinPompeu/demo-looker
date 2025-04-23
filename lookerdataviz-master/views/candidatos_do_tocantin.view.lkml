# The name of this view in Looker is "Candidatos Do Tocantin"
view: candidatos_do_tocantin {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `edp-k1-dwh-cur.edp_k1_dwh_cur_bq_0.candidatos_do_tocantin`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ano Eleicao" in Explore.

  dimension: ano_eleicao {
    type: number
    sql: ${TABLE}.ANO_ELEICAO ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_ano_eleicao {
    type: sum
    sql: ${ano_eleicao} ;;
  }

  measure: average_ano_eleicao {
    type: average
    sql: ${ano_eleicao} ;;
  }

  dimension: ds_cargo {
    type: string
    sql: ${TABLE}.DS_CARGO ;;
    html: "<div style="background-color: black; color: white; padding: 20px; width: 300px; font-family: sans-serif; border-radius: 10px;">

  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
    <div>
      <p style="font-weight: bold; margin: 0;">SEASON VALUE</p>
      <p style="font-size: 24px; margin: 0;">$44,635</p>
    </div>
    <div style="text-align: right;">
      <p style="margin: 0;">$750</p>
      <select style="background-color: transparent; color: white; border: 1px solid white; border-radius: 5px; padding: 5px;">
        <option>Spending</option>
      </select>
    </div>
  </div>

  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
    <div>
      <p style="font-weight: bold; margin: 0;">LIFETIME VALUE</p>
      <p style="font-size: 24px; margin: 0;">$112,274</p>
    </div>
    <div style="text-align: right;">
      <p style="margin: 0;">$500</p>
      <p style="margin: 0;">$250</p>
    </div>
  </div>
"
    ;;
  }

  dimension: ds_eleicao {
    type: string
    sql: ${TABLE}.DS_ELEICAO ;;
  }

  dimension: ds_genero {
    type: string
    sql: ${TABLE}.DS_GENERO ;;
  }

  dimension: ds_sit_tot_turno {
    type: string
    sql: ${TABLE}.DS_SIT_TOT_TURNO ;;
  }

  dimension: dt_nascimento {
    type: string
    sql: ${TABLE}.DT_NASCIMENTO ;;
  }

  dimension: nm_candidato {
    type: string
    sql: ${TABLE}.NM_CANDIDATO ;;
    link: {
      label: "Google"
      url: "https://www.google.com/search?q={{ value }}"
      icon_url: "https://google.com/favicon.ico"
    }
    #drill_fields: [profile]
  }

  measure: info {
    group_label: "info icone"
    type: sum
    sql:0 ;;
    drill_fields: [como_usar_dashboard]
    html:
      <a href="#drillmenu" target="_self">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Information_icon.svg/2048px-Information_icon.svg.png" style="width 4.6em; height: 4.8em; padding: 1.4em 0.7em 0.5em 0.5em">
      </a>
    ;;
  }

  dimension: como_usar_dashboard {
    group_label: "info icone"
    type: string
    sql: DISTINCT '' ;;
    html:
      <div style="
        display: border-box;
        vertical-align: top;
        border: 1px solid #D6D6D6;
        height: 50vh;
        width: 100%;
        border-radius: 4px;
        background-color: #F4F4F4;
        text-align: center;
        font-size: 18px;
        margin: 20px auto;
        padding: 10px;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        overflow: auto;
      ">
        <div style="font-weight: 600">Como usar esse Dashboard:</div>
        <div style="padding-top: 1.4em">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.
          Aliquam nonummy auctor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
          Nulla at risus. Quisque purus magna, auctor et, sagittis ac, posuere eu, lectus. Nam mattis, felis ut adipiscing
        </div>
      </div>
    ;;
  }

  dimension: profile {
    sql: ${TABLE}.NM_CANDIDATO ;;
    html: <a href="/explore/tre-to/candidatos_do_tocantin?fields=candidatos_do_tocantin.nm_candidato,candidatos_do_tocantin.sg_partido,candidatos_do_tocantin.ano_eleicao,candidatos_do_tocantin.sg_partido*&f[candidatos_do_tocantin.nm_candidato]={{ value }}">Partidos/Ano</a>;;
  }



  dimension: nm_ue {
    type: string
    sql: ${TABLE}.NM_UE ;;
  }

  dimension: nr_turno {
    type: number
    sql: ${TABLE}.NR_TURNO ;;
  }

  dimension: sg_partido {
    type: string
    sql: ${TABLE}.SG_PARTIDO ;;

    html: {% if value == 'PDT' %}
    <a href="https://www.tse.jus.br/partidos/partidos-registrados-no-tse/partido-democratico-trabalhista"><button>{{value}}</button></a>

    {% elsif value == 'Safe' %}
    <a href="https://www.tse.jus.br/partidos/partidos-registrados-no-tse/partido-socialista-brasileiro"><button>{{value}}</button></a>

    {% else %}
    <a href="https://www.tse.jus.br/partidos/partidos-registrados-no-tse/"><button>{{value}}</button></a>
    {% endif %}
    ;;

  }

  dimension: tp_eleicao {
    type: string
    sql: ${TABLE}.TP_ELEICAO ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
