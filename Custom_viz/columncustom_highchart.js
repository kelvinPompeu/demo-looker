looker.plugins.visualizations.add({
  create: function(element, config) {
    this.container = element.appendChild(document.createElement("div"));
    this.container.classList.add('pictorial-chart-container');
    this.container.id = 'container';
    console.log("create function called");
  },
  update: function(dataLooker, element, config, queryResponse) {
    console.log("update function called");
    console.log("data:", dataLooker);
    console.log("config:", config);
    console.log("queryResponse:", queryResponse);
    console.log("Config object:", config);

    const countries = {
      kr: { name: 'South Korea', color: '#FE2371' },
      jp: { name: 'Japan', color: '#544FC5' },
      au: { name: 'Australia', color: '#2CAFFE' },
      de: { name: 'Germany', color: '#FE6A35' },
      ru: { name: 'Russia', color: '#6B8ABC' },
      cn: { name: 'China', color: '#1C74BD' },
      gb: { name: 'Great Britain', color: '#00A6A6' },
      us: { name: 'United States', color: '#D568FB' }
    };

    for (const [key, value] of Object.entries(countries)) {
      value.ucCode = key.toUpperCase();
    }
        const categorias = [...new Set(dataLooker.map(row => row.pais))];


    // Função para formatar os dados para Highcharts
    const formatData = (data, ano, isAnoAnterior = false) => {
      return data.filter(row => row.ano === ano).map(row => ({
        name: row.pais,
        y: row.num_medalhas,
        color: isAnoAnterior ? 'rgba(158, 159, 163, 0.5)' : countries[row.pais].color
      }));
    };

    // Obter os anos únicos dos dados
    const anos = [...new Set(dataLooker.map(row => row.ano))];

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
        accessibility: { description: 'categorias' },
      },
      yAxis: [{ title: { text: 'Gold medals' }, showFirstLabel: false }],
      series: [{
        color: 'rgba(158, 159, 163, 0.5)', pointPlacement: -0.2, linkedTo: 'main',
        data: formatData(dataLooker, anoAnterior, true), // Cor cinza para o ano anterior
        name: anoAnterior.toString()
      }, {
        name: anoAtual.toString(), id: 'main', dataSorting: { enabled: true, matchByName: true },
        dataLabels: [{ enabled: true, inside: true, style: { fontSize: '16px' } }],
        data: formatData(dataLooker, anoAtual)
      }],
      exporting: { allowHTML: true }
    });
  }
});