$(document).ready(function() {

  var g = {
    nodes: [],
    edges: []
  };

  s = new sigma({
    graph: g,
    container: 'graph-container',
    renderer: {
      container: document.getElementById('graph-container'),
      type: 'canvas'
    },
    settings: {
      minNodeSize: 16,
      maxNodeSize: 16,
      labelThreshold: 20,
      defaultNodeType: 'custom'
    }
  });

  sigma.parsers.json('/neural_nets/4.json',
    s,
    function() {
      // this below adds x, y attributes as well as size = degree of the node
      var i,
      nodes = s.graph.nodes(),
      len = nodes.length;

      // Refresh the display:
      s.refresh();
  });
});
