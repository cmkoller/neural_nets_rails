sigma.utils.pkg('sigma.canvas.nodes');
sigma.canvas.nodes.border = (function() {

  // Return the renderer itself:
  var renderer = function(node, context, settings) {
    var prefix = settings('prefix') || '';

    context.fillStyle = node.color || settings('defaultNodeColor');
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
    context.fill();

    context.lineWidth = node.borderWidth || 3;
    context.strokeStyle = node.borderColor || '#fff';
    context.stroke();
  };

      return renderer;
    })();
