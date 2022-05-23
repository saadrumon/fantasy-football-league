$(document).ready(function() {
  if($('#dashboard').length) {
    const chart_ids = ["chart_1", "chart_2", "chart_3"];
    const card_ids = ["card_1", "card_2", "card_3"];
    const select_ids = ["select_1", "select_2", "select_3"];
    const button_ids = ["button_1", "button_2", "button_3"];
    const types = ["bar", "pie", "pie"]
    const labels = ["Points", "Goals scored", "Goals conceded"]
    for(let i = 0; i < chart_ids.length; i++) {
      create_chart(chart_ids[i], card_ids[i], select_ids[i], types[i], labels[i]);

      $(`#${button_ids[i]}`).click(function () {
        create_chart(chart_ids[i], card_ids[i], select_ids[i], types[i], labels[i]);
      });
    }
  }
});

function get_colors(no_of_category, start_index=0) {
  let colors = [
    "#3366cc", "#dc3912", "#ff9900", "#109618",
    "#990099", "#0099c6", "#dd4477", "#66aa00",
    "#b82e2e", "#316395", "#3366cc", "#994499",
    "#22aa99", "#aaaa11", "#6633cc", "#e67300",
    "#8b0707", "#651067", "#329262", "#5574a6",
    "#3b3eac", "#b77322", "#16d620", "#b91383",
    "#f4359e", "#9c5935", "#a9c413", "#2a778d",
    "#668d1c", "#bea413", "#0c5922", "#743411"
  ];
  let colors_arr = [];
  for (let index = 0; index < no_of_category; ++index) {
      colors_arr.push(colors[(start_index + index) % colors.length]);
  }
  return colors_arr;
}

function create_chart(chart_id, card_id, select_id, type, label) {
  $(`#${chart_id}`).remove();
  let new_canvas_elem = document.createElement('canvas');
  new_canvas_elem.setAttribute("id", `${chart_id}`);
  $(`#${card_id} .card-body`).append(new_canvas_elem);
  const selected_season = $(`#${select_id}`).find(":selected").text();

  const ctx = document.getElementById(`${chart_id}`).getContext('2d');
  const labels = JSON.parse(document.getElementById(`${card_id}`).dataset.labels)[selected_season];
  const data =  JSON.parse(document.getElementById(`${card_id}`).dataset.data)[selected_season];
  const chart = new Chart(ctx, {
      type: `${type}`,
      data: {
          labels: labels,
          datasets: [{
              label: label,
              data: data,
              backgroundColor: get_colors(labels.length),
              borderColor: get_colors(labels.length),
              borderWidth: 1
          }]
      },
      options: {
          scales: {
              y: {
                  beginAtZero: true
              }
          }
      }
  });

}
