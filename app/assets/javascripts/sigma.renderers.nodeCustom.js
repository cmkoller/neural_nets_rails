sigma.utils.pkg('sigma.canvas.nodes');
sigma.canvas.nodes.custom = (function() {

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

    // context.fillStyle = "#fff";
    // context.fill();

    // context.fillStyle = node.color || settings('defaultNodeColor');
    // context.fill();

    context.lineWidth =  1;
    context.strokeStyle = '#000';
    context.stroke();

    x = node[prefix + 'x']
    y = node[prefix + 'y']

    var lingrad = context.createLinearGradient(x,x + 10,y,y + 10);
    lingrad.addColorStop(0, '#00ABEB');
    lingrad.addColorStop(0.5, '#fff');
    lingrad.addColorStop(0.5, '#26C000');
    lingrad.addColorStop(1, '#fff');
    context.fillStyle = lingrad;
    context.fill();

  };

  return renderer;
})();
