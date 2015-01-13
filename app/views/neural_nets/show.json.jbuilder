# json.extract! @neural_net, :serve_nodes_for_sigma

json.nodes @neural_net.num_layers.times do |l|
  @neural_net.loop_over_nodes(l) do |index|
    node = layer_n_nodes(l)[i]
    json.id node.id
    json.x 100 / @neural_net.layer_n_nodes(node.layer).length / 2
  end
end
