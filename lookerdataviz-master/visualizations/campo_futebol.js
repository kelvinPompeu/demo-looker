looker.plugins.visualizations.add({
      create: function(element, config) {
        // Chamado uma vez na inicialização.
        // Usado para setup inicial que NÃO depende de dados.
        // Ex: Adicionar um container div específico para o Highcharts.
        element.innerHTML = '<div id="hicharts-container-id" style="width: 100%; height: 100%;"></div>';
        console.log("Vis Create called");
    },
    updateAsync: function(data, element, config, queryResponse, details, doneRendering) {
        this.clearErrors();

        if (!data || data.length === 0) {
            console.warn("Sem dados para exibir.");
            element.innerHTML = "Sem dados disponíveis.";
            doneRendering();
            return;
        }

        // --- Assumindo nomes dos campos do Looker ---
        // Ajuste conforme sua query
        const xField = queryResponse.fields.dimensions.find(f => f.name.includes("xField")).name; // Dimensão para X (colunas)
        const yField = queryResponse.fields.dimensions.find(f => f.name.includes("yField")).name;
        const resultField = queryResponse.fields.dimensions.find(f => f.name.includes("resultField")).name;
        const nome_jogado = queryResponse.fields.dimensions.find(f => f.name.includes("nomejogador")).name;

        // --- URLs e Configs dos Marcadores ---
        const urlBola = 'https://files.softicons.com/download/sport-icons/vista-sport-icons-by-icons-land/png/256x256/Soccer_Ball.png';
        const urlx = 'https://www.freeiconspng.com/uploads/red-x-png-7.png'


      let pontosGol = [];
      let pontosErro = [];


        // 2. Processar dados do Looker
        data.forEach(row => {
            const xValue = row[xField].value; // Use LookerCharts.Utils.textForCell se preferir
            const yValue = row[yField].value;
            const resultado = row[resultField].value;
            const nome_jogador = row[nome_jogado].value;

            console.log("xValue: " + xValue)
            console.log("yValue: " + yValue)
            console.log("resultado: " + resultado)

        // Criar o objeto base do ponto com as coordenadas e dados customizados
        // Note que NÃO definimos o 'marker' aqui, pois ele será definido para a série inteira
        const pontoBase = {
            x: xValue,
            y: yValue,
            custom: { // Guardamos o resultado aqui, útil para tooltips
                resultado: resultado || 'N/D', // Valor padrão 'N/D' se resultado for nulo/undefined
                nome_jogador: nome_jogador
            }
        };

        // Verificar o resultado e adicionar o ponto ao array correspondente
        if (resultado && String(resultado).toLowerCase() === 'gol') {
            // Se for gol, adiciona ao array de gols
            pontosGol.push(pontoBase);
        } else {
            // Caso contrário (erro ou outro valor), adiciona ao array de erros
            pontosErro.push(pontoBase);
        }
        });

        // 3. Montar opções do Highcharts
        const options = {
            chart: {
                type: 'scatter',
                plotBackgroundImage: 'https://static.vecteezy.com/ti/vetor-gratis/p1/13222731-ilustracao-de-fundo-de-campo-de-futebol-com-design-simples-e-tamanho-4k-vetor.jpg',
            },
            title: {
                text: config.title || 'Chutes no Campo' // Título da config ou padrão
            },
            xAxis: {
                visible: false, // Esconde eixo X
                 min: 0,
                 max: 100
            },
            yAxis: {
                visible: false, // Esconde eixo Y
                min: 0,
                max: 50
            },
            // Tooltip para mostrar informação ao passar o mouse
            tooltip: {
                 enabled: config.show_tooltip !== undefined ? config.show_tooltip : true,
                 formatter: function() {
                     // Exibe o resultado e as coordenadas
                     return `<b>Nome DO Jogador:</b> ${this.point.custom.nome_jogador}<br/>X: ${this.point.x}, Y: ${this.point.y}`;
                 }
                 // Ou usando pointFormat se os dados estiverem diretamente no ponto:
                 // pointFormat: 'Resultado: {point.custom.resultado}<br/>Pos: ({point.x}, {point.y})'
             },
            legend: {
                 enabled: true // Provavelmente não precisa de legenda para uma única série assim
            },
            series: [
                {
                    name: 'Gol',
                    type: 'scatter',
                    marker: { // Marcador para a série Gol
                         symbol: 'url(' + urlBola + ')', // Sua URL local
                         width: 21,
                         height: 21
                     },
                    data: pontosGol // <<< USA O ARRAY DE GOLS AQUI
                },
                {
                    name: 'Erro',
                    type: 'scatter',
                    marker: { // Marcador para a série Erro
                        symbol: 'url(' + urlx + ')', // Sua URL local
                        width: 21,
                        height: 21
                     },
                    data: pontosErro // <<< USA O ARRAY DE ERROS AQUI
                }
            ],
            credits: {
                 enabled: false
            }
        };

        // 4. Renderizar o gráfico
        Highcharts.chart(element, options);

        doneRendering();
    }
});
