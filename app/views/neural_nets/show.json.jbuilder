layer_height = 100 / @neural_net.num_layers
nodes_in_layer = Hash.new(0)

json.nodes @neural_net.nodes do |node|
  current_layer = node.layer
  node_index_in_row = nodes_in_layer[current_layer]
  nodes_in_layer[current_layer] += 1
  column_width = 100 / @neural_net.layer_n_nodes(node.layer).length

  json.id node.id.to_s
  json.label "#{node.id}: #{node.output}"
  json.x column_width / 2 + node_index_in_row * column_width
  json.y current_layer * layer_height
  json.size 3
  json.type node.active? ? "border" : "custom"
  json.color "rgba(104, 87, 130,#{node.output})"
end

json.edges @neural_net.connections do |conn|
  json.id conn.id.to_s
  json.source conn.parent.id.to_s
  json.target conn.child.id.to_s
  json.label "#{conn.weight}"
  json.color conn.weight >= 0 ? "#FFBB78" : "#AEC7E8"
  json.size conn.weight.abs
end
