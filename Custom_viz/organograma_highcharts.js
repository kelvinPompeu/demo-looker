looker.plugins.visualizations.add({
    updateAsync: function(data, element, config, queryResponse, details, doneRendering) {
        // Limpar erros anteriores
        this.clearErrors();

        // 0. Validar se os dados necessários vieram
        if (!data || data.length === 0) {
            // Tratar caso sem dados
            console.warn("Sem dados para exibir.");
            doneRendering();
            return;
        }

        // Obter nomes dos campos da consulta (exemplo, ajuste conforme sua consulta)
        // É crucial usar os nomes exatos dos seus campos no Looker
        const idField =  "id"
        const parentField = "parent_id"
        const nameField = "name"
        const imageField = "image_url"
        const colorField = "color"
        const titleField = "title"
        const customInfoField =  "custom_info"


        let highchartsDataLinks = [];
        let highchartsNodes = [];
        let nodesAdded = new Set(); // Para evitar adicionar o mesmo nó múltiplas vezes

        // 2. Iterar sobre os dados do Looker para construir os arrays
        data.forEach(row => {
            const childId = row[idField]; // Pega o valor da célula
            const parentId = row[parentField];
            const childName = row[nameField];
            const childImage = row[imageField];
            const childColor = row[colorField]; // Cor padrão se não houver
            const childTitle = row[titleField]; // ou name se preferir
            const childCustomInfo = row[customInfoField];


            // Adicionar o link (conexão) se houver um pai
            if (parentId && parentId !== '' && parentId !== childId) { // Evita links para si mesmo ou sem pai definido
                 highchartsDataLinks.push([parentId, childId]);
            }

            // Adicionar o nó filho (se ainda não foi adicionado)
            if (!nodesAdded.has(childId)) {
                highchartsNodes.push({
                    id: childId,
                    name: childName, // Nome exibido no nó
                    title: childTitle, // Pode ser usado para cargo ou subtítulo, ou deixar null
                    image: childImage, // URL da imagem (se houver)
                    color: childColor, // Cor do nó (se houver)
                    custom: { // Para usar no tooltip, como no seu exemplo
                        info: childCustomInfo
                    }
                    // Adicione outras propriedades customizadas se precisar
                });
                nodesAdded.add(childId);
            }
        });

        // 3. Montar o objeto de opções do Highcharts
        const options = {
            chart: {
                height: 600, // Ou dinâmico baseado no container 'element.clientHeight'
                inverted: false // Organograma vertical (false) ou horizontal (true)
            },
            title: {
                text: config.chart_title || 'Organograma Dinâmico' // Título dinâmico da config do Looker
            },
            subtitle: {
                 text: config.chart_subtitle || ''
             },
             plotOptions: {
                 series: {
                     nodeWidth: config.node_width || '22%' // Largura do nó da config
                 }
             },
            series: [{
                type: 'organization',
                name: 'Hierarquia', // Nome genérico
                keys: ['from', 'to'],
                data: highchartsDataLinks, // ARRAY DE LINKS DINÂMICO
                levels: [ // Você pode manter os levels fixos ou torná-los dinâmicos também
                    // ... configuração dos levels ...
                    // Exemplo: ler cores/opções dos levels da config do Looker
                     { level: 0, color: config.level_0_color || '#DEDDCF', dataLabels: { color: 'black' } },
                     { level: 1, color: config.level_1_color || '#DEDDCF', dataLabels: { color: 'black' } },
                     // ... etc ...
                ],
                nodes: highchartsNodes, // ARRAY DE NÓS DINÂMICO
                colorByPoint: false, // Geralmente false para organization chart se você define cor por nó
                borderColor: config.border_color || 'black',
                borderWidth: 2,
                dataLabels: { // Estilo padrão dos labels nos nós
                     enabled: true,
                     // format: '{point.name}' // O que exibir (pode ser customizado)
                 },
            }],
             tooltip: { // Configuração do tooltip pode ser dinâmica também
                 outside: true,
                 enabled: config.show_tooltip !== undefined ? config.show_tooltip : true,
                 format: '{point.custom.info}' // Usa a informação customizada que veio do Looker
             }
        };

        // 4. Renderizar o gráfico Highcharts
        Highcharts.chart(element, options); // 'element' é o container div da visualização no Looker

        // Sinalizar que a renderização terminou
        doneRendering();
    }
});