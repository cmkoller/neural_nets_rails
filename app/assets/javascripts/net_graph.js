$(document).ready(function() {
if ($(".neural_nets.show").length > 0 || $(".neural_nets.update").length > 0) {
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
        minEdgeSize: 1,
        maxEdgeSize: 10,
        labelThreshold: 30,
        edgeLabelSize: 'proportional',
        sideMargin: 3,
        zoomMin: 0.4,
        activeColor: "#FFA74C",
        nodePurple:" #3E2B73",
        biasNodeColor: "#00BD3E"
      }
    });

    sigma.parsers.json(window.location.pathname + '.json',
      s,
      function() {
        // this below adds x, y attributes as well as size = degree of the node
        var i,
        nodes = s.graph.nodes(),
        len = nodes.length;

        // Refresh the display:
        s.refresh();
    });
  }
});
