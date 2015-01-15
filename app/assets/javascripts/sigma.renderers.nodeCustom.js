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

    context.shadowColor = 'transparent';
    context.shadowBlur = 15;

    context.fillStyle = "#fff";
    context.fill();

    context.fillStyle = node.color || settings('defaultNodeColor');
    context.fill();

    context.lineWidth =  5;
    context.strokeStyle = '#685782';
    context.stroke();

  };

  return renderer;
})();