sigma.utils.pkg('sigma.canvas.nodes');
sigma.canvas.nodes.border = (function() {

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

    // context.shadowColor = '#FFE500';
    // context.shadowBlur = 15;
    // context.fill();


    context.lineWidth =  13;
    context.strokeStyle = '#FFBB78';
    context.stroke();

    context.fillStyle = "#fff";
    context.fill();

    context.fillStyle = node.color || settings('defaultNodeColor');
    context.fill();

    context.lineWidth =  5;
    context.strokeStyle = '#9467BD';
    context.stroke();

  };

      return renderer;
    })();
