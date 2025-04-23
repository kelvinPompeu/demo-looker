looker.plugins.visualizations.add({
  id: "column_custom",
  label: "compare 2 dates",
  create: function(element, config) {
    this.container = element.appendChild(document.createElement("div"));
    this.container.classList.add('pictorial-chart-container');
    this.container.id = 'container';
    console.log("create function called");
  },
  updateAsync: function(data, element, config, queryResponse, details, done) {
    console.log("update function called");
    console.log("data:", data);
    console.log("config:", config);
    console.log("queryResponse:", queryResponse);
    console.log("Config object:", config);

    const countries = {
      ca: { name: 'Canada', color: '#FE2371' },
      jp: { name: 'Japan', color: '#544FC5' },
      au: { name: 'Australia', color: '#2CAFFE' },
      de: { name: 'Germany', color: '#FE6A35' },
      br: { name: 'Brazil', color: '#6B8ABC' },
      ch: { name: 'China', color: '#1C74BD' },
      gb: { name: 'Great Britain', color: '#00A6A6' },
      us: { name: 'United States', color: '#D568FB' }
    };

    for (const [key, value] of Object.entries(countries)) {
      value.ucCode = key.toUpperCase();
    }

    const paisField = queryResponse.fields.dimensions.find(f => f.name.includes('pais')).name;
    const anoField = queryResponse.fields.dimensions.find(f => f.name.includes('ano')).name;
    const num_medalhasField = queryResponse.fields.measures.find(f => f.name.includes('num_medalhas')).name;

    console.log("paisField", paisField);
    console.log("anoField", anoField);
    console.log("num_medalhasField", num_medalhasField);

    // Função para formatar os dados para Highcharts
    const formatData = (data, ano, isAnoAnterior = false) => {
      return data.filter(row => row[anoField].value === ano).map(row => ({
        name: row[paisField].value,
        y: row[num_medalhasField].value,
        color: isAnoAnterior ? 'rgba(158, 159, 163, 0.5)' : countries[row[paisField].value].color
        }));
    };

    console.log("formatData", formatData);
    console.log("formatData(data, anoAtual):", formatData(data, Math.max(...[...new Set(data.map(row => row[anoField].value))])));
    console.log("formatData(data, anoAnterior, true):", formatData(data, Math.min(...[...new Set(data.map(row => row[anoField].value))].filter(ano => ano !== Math.max(...[...new Set(data.map(row => row[anoField].value))]))), true));


    // Obter os anos únicos dos dados
    const anos = [...new Set(data.map(row => row[anoField].value))];

    // Obter o ano atual e o ano anterior
    const anoAtual = Math.max(...anos);
    const anoAnterior = Math.min(...anos.filter(ano => ano !== anoAtual));

    Highcharts.chart('container', {
      chart: { type: 'column' },
      countries,
      title: { text: `Medalhas Olímpicas ${anoAtual} vs ${anoAnterior}`, align: 'left' },
      subtitle: {
        text: `Comparando ${anoAtual} com ${anoAnterior} - Fonte: Olympics`,
        align: 'left'
      },
      plotOptions: {
        series: {
          grouping: false,
          borderWidth: 0,
          dataLabels: {
            enabled: true,
            format: '{y}',
            style: {
              fontWeight: 'bold',
              fontSize: '14px'
            }
          }
        }
      },
      legend: { enabled: false },
      tooltip: {
        shared: true,
        headerFormat: '<span style="font-size: 15px">{point.name}</span><br/>',
        pointFormat: '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y} medals</b><br/>'
      },
      xAxis: {
        type: 'category',
        accessibility: {
          description: 'Countries'
          },
        max: 4,
        labels: {
          useHTML: true,
          animate: true,
          formatter: function () {
            const label = this.axis.defaultLabelFormatter.call(this);
            return `<span>${label}</span><br><img style="display:inline-block;height:32px;" src="https://www.worldometers.info//img/flags/small/tn_${label}-flag.gif">`;
          },
          style: {
            textAlign: 'center'
          }
        }
      },
      yAxis: [{ title: { text: 'Gold medals' }, showFirstLabel: false }],
      series: [{
        color: 'rgba(158, 159, 163, 0.5)', pointPlacement: -0.2, linkedTo: 'main',
        data: formatData(data, anoAnterior, true), // Cor cinza para o ano anterior
        name: anoAnterior.toString()
      }, {
        name: anoAtual.toString(), id: 'main', dataSorting: { enabled: true, matchByName: true },
        dataLabels: [{ enabled: true, inside: true, style: { fontSize: '16px' } }],
        data: formatData(data, anoAtual)
      }],
      exporting: { allowHTML: true }
    });
  }
});
