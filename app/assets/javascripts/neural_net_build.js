var layerButtonsText = "<div class=\"layer-wrap\">\
  <div class=\"layer row\">\
  <button class=\"small delete node-edit-button\">x</button>\
  <button class=\"small add node-edit-button\">+</button>\
  </div></div>"

var nodeText = "<div class=\"node-cell\"><div class=\"node\">\
  <input id=\"neural_net_nodes_attributes_0_layer\"\
    name=\"neural_net[nodes_attributes][][layer]\"\
    type=\"hidden\" value=\"0\" />\
  </div></div>"

$(document).ready(function() {

  // New Layer button
  $(".neural-net-new-layer").on("click", function(e) {
    e.preventDefault();

    // Add new layer
    $(".neural-net-layers").append(layerButtonsText);

    // New Node button
    $(".add").on("click", function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();

      $(this).before(nodeText);
    });

    // Delete Node button
    $(".delete").on("click", function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();


      $(this).next().remove();
    });
  });

  // Delete Layer Button
  $(".neural-net-delete-layer").on("click", function(e) {
    e.preventDefault();

    $('.layer').last().remove();

  });


});
