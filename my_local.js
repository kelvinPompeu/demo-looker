looker.plugins.visualizations.add({
  create: function(element, config) {
    this.container = element.appendChild(document.createElement("div"));
    this.container.classList.add("ictorial-table-container");
  },
  update: function(data, element, config, queryResponse) {
    this.container.innerHTML = "

    const table = document.createElement("able");
    table.classList.add("ictorial-table");

    const imageUrl = config.imageUrl || "https://cdn-icons-png.flaticon.com/128/52/52902.png";
    const scaleValue = config.scaleValue || 100;
    const textColor = config.textColor || "#333";
    const valueColor = config.valueColor || "#666";
    const iconSize = config.iconSize || 45;
    const iconHeight = config.iconHeight || 30;

    const title = document.createElement("3");
    title.classList.add("ictorial-title");
    title.textContent = config.customTitle || "Título do Gráfico";
    this.container.appendChild(title);

    data.forEach(row => {
      const category = row.Categoria;
      const value = row.Valor;
      const iconCount = Math.floor(value / scaleValue);

      const tr = document.createElement("r");
      const tdCategory = document.createElement("d");
      tdCategory.textContent = category;
      tdCategory.style.color = textColor;
      tr.appendChild(tdCategory);

      const tdIcons = document.createElement("d");
      tdIcons.classList.add("con-cell");
      for (let i = 0; i < iconCount; i++) {
        const icon = document.createElement("mg");
        icon.src = imageUrl;
        icon.width = iconSize;
        icon.height = iconHeight;
        tdIcons.appendChild(icon);
      }
      tr.appendChild(tdIcons);

      const tdValue = document.createElement("d");
      tdValue.textContent = value;
      tdValue.style.color = valueColor;
      tr.appendChild(tdValue);

      table.appendChild(tr);
    });

    const legend = document.createElement("iv");
    legend.classList.add("ictorial-legend");
    legend.style.color = textColor;
    legend.innerHTML = `<img src="${imageUrl}" width="${iconSize}" height="${iconHeight}" style="vertical-align: middle;"> = ${scaleValue} pessoas`;

    this.container.appendChild(table);
    this.container.appendChild(legend);

    const style = document.createElement("tyle");
    style.innerHTML = `
        .pictorial-table {
          width: 100%;
          border-collapse: collapse;
          font-family: sans-serif;
        }
        .pictorial-table td {
          padding: 8px;
          border-bottom: 1px solid #ddd;
          text-align: center;
          vertical-align: middle;
          font-size: 14px;
        }
        .icon-cell {
          text-align: left;
          padding-left: 10px;
        }
        .pictorial-legend {
          font-size: 12px;
          margin-top: 5px;
          text-align: right;
        }
        .pictorial-title {
          font-size: 20px;
          font-weight: bold;
          text-align: center;
          margin-bottom: 10px;
          color: ${config.titleColor || "#333"};
        }
    `;
    this.container.appendChild(style);
  },
  options: {
    customTitle: {
      type: "string",
      label: "Título do Gráfico",
      default: "Título do Gráfico"
    },
    titleColor: {
      type: "string",
      label: "Cor do Título",
      default: "#333",
      display: "color"
    },
    imageUrl: {
      type: "string",
      label: "URL da Imagem",
      default: "https://cdn-icons-png.flaticon.com/128/52/52902.png"
    },
    scaleValue: {
      type: "number",
      label: "Valor da Escala",
      default: 100
    },
    textColor: {
      type: "string",
      label: "Cor do Texto",
      default: "#333",
      display: "color",
    },
    valueColor: {
      type: "string",
      label: "Cor dos Valores",
      default: "#666",
      display: "color",
    },
    iconSize: {
      type: "number",
      label: "Tamanho do Icone",
      default: 45,
    },
    iconHeight: {
      type: "number",
      label: "Altura do Icone",
      default: 30,
    }
  }
});