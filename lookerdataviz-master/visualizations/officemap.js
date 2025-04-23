looker.plugins.visualizations.add({
  id: "heatmap_floorplan",
  label: "Mapa de Calor Planta Baixa",
  create: function(element, config) {
    this.chart = null;
    this.container = element.appendChild(document.createElement("div"));
    this.container.style.width = "100%";
    this.container.style.height = "100%";
  },
  update: function(data, element, config, queryResponse) {
    if (!data || data.length === 0) {
      this.chart ? this.chart.destroy() : null;
      this.container.innerHTML = "Nenhum dado para exibir.";
      return;
    }

    const dimensionFieldX = queryResponse.fields.dimensions.find(f => f.name.includes('x')).name; // Dimensão para X (colunas)
    const dimensionFieldY = queryResponse.fields.dimensions.find(f => f.name.includes('y')).name; // Dimensão para Y (linhas)
    const measureField = queryResponse.fields.measures.find(f => f.name.includes('valor')).name;  // Medida para a intensidade

    console.log("dimensionFieldX", dimensionFieldX )
    console.log("dimensionFieldY", dimensionFieldY )
    console.log("measureField", measureField)

    if (!dimensionFieldX || !dimensionFieldY || !measureField) {
      this.container.innerHTML = "Certifique-se de selecionar uma dimensão para X, uma dimensão para Y e uma medida.";
      return;
    }

    // Processar os dados do Looker para o formato do Highcharts
    const seriesData = data.map(row => {
      console.log("row[dimensionFieldX]", row[dimensionFieldX])
      console.log("row[dimensionFieldY]", row[dimensionFieldY])
      console.log("row[measureField]", row[measureField])

      return {
        x: row[dimensionFieldX].value,
        y: row[dimensionFieldY].value,
        value: row[measureField].value
      };
    });

    console.log("Looker Data:", JSON.stringify(seriesData)); // Log dos dados do Looker

   const options = {
      chart: {
        type: 'heatmap',
        height: '100%',
        plotBackgroundImage: 'https://datavis.blog/wp-content/uploads/2021/10/floor-1.png?w=1314' // Evita que o Highcharts tente colocar a imagem
      },
      title: {
        text: 'Mapa de Calor da Planta Baixa'
      },
      xAxis: {
        visible: false,
        margin: 0,
        minPadding: 0,
        maxPadding: 0
      },
      yAxis: {
        visible: false,
        endOnTick: false,
        minPadding: 0,
        maxPadding: 0
      },
      tooltip: {
        pointFormat: `X: {point.x}, Y: {point.y}, Valor: {point.value}`
      },
      colorAxis: {
        stops: [
            [0, 'rgba(61, 0, 255, 0.2)'],
            [0.3, 'rgba(0, 255, 188, 0.3)'],
            [0.6, 'rgba(194, 255, 0, 0.6)'],
            [0.9, 'rgba(255, 0, 67, 0.9)']
        ]
      },
      series: [{
        name: 'Intensidade',
        data: seriesData,
        interpolation: true // Sem interpolação entre as células
      }],
      responsive: {
        rules: [{
          condition: {
            minWidth:600 // Ajuste conforme necessário
          },
          chartOptions: {
            chart: {
              height: 600 // Ajuste conforme necessário
            }
          }
        }]
      }
    };

    if (!this.chart) {
      this.chart = Highcharts.chart(this.container, options);
    } else {
      this.chart.update(options);
    }
  }
});
