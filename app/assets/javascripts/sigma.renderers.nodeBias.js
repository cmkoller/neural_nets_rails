sigma.utils.pkg('sigma.canvas.nodes');
sigma.canvas.nodes.bias = (function() {

  // Return the renderer itself:
  var renderer = function(node, context, settings) {
    var prefix = settings('prefix') || '';

    context.beginPath();
    context.arc(
      node[prefix + 'x'],
      node[prefix + 'y'],
      node[prefix + 'size'],
      0,
      Math.PI * 2,
      true
    );

    context.closePath();

    context.lineWidth =  19;
    context.strokeStyle = settings('activeColor');
    context.stroke();

    context.lineWidth =  9;
    context.strokeStyle = settings('nodePurple');
    context.stroke();

    context.fillStyle = "#fff";
    context.fill();

    context.fillStyle = settings('biasNodeColor');
    context.fill();

    context.lineWidth =  2;
    context.strokeStyle = '#fff';
    context.stroke();
  };

  return renderer;
})();
