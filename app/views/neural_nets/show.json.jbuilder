node_index_in_row = 0
current_layer = 0
layer_height = 100 / @neural_net.num_layers

json.nodes @neural_net.nodes do |node|
  if current_layer != node.layer
    node_index_in_row = 0
  end
  current_layer = node.layer
  column_width = 100 / @neural_net.layer_n_nodes(node.layer).length

  json.id node.id.to_s
  json.label node.output.to_s
  json.x column_width / 2 + node_index_in_row * column_width
  json.y current_layer * layer_height
  json.size 3
  json.type node.active? ? "border" : "custom"
  json.color "rgba(255,140,0,#{node.output})"

  node_index_in_row += 1
end

json.edges @neural_net.connections do |conn|
  json.id conn.id.to_s
  json.source conn.parent.id.to_s
  json.target conn.child.id.to_s
  json.label "#{conn.weight}"
  json.color conn.weight >= 0 ? "#0fa" : "#fa0"
  json.size conn.weight.abs
end
