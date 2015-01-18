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
    context.strokeStyle = '#FFA74C';
    context.stroke();

    context.lineWidth =  9;
    context.strokeStyle = '#3E2D72';
    context.stroke();

    context.fillStyle = "#fff";
    context.fill();

    context.fillStyle = "#38BD64"//node.color || settings('defaultNodeColor');
    context.fill();

    context.lineWidth =  2;
    context.strokeStyle = '#fff';
    context.stroke();
  };

  return renderer;
})();
