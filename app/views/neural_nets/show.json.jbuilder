layer_height = 100 / @neural_net.num_layers
nodes_in_layer = Hash.new(0)

json.nodes @neural_net.nodes do |node|
  current_layer = node.layer
  node_index_in_row = nodes_in_layer[current_layer]
  column_width = 100 / @neural_net.nonbias_layer_n_nodes(node.layer).length
  unless node.bias?
    nodes_in_layer[current_layer] += 1
  end

  if node.bias?
    type = "bias"
  elsif node.active?
    type = "border"
  else
    type = "custom"
  end

  json.id node.id.to_s
  json.label "  Output: #{node.output}"
  json.x node.bias? ? 100 : (column_width / 2 + node_index_in_row * column_width)
  json.y current_layer * layer_height
  json.size 3
  json.type type
  json.color "rgba(64, 45, 114,#{node.output})"
end

json.edges @neural_net.connections do |conn|
  json.id conn.id.to_s
  json.source conn.parent.id.to_s
  json.target conn.child.id.to_s
  json.label "            #{conn.weight}"
  json.color conn.weight >= 0 ? "#FFA74C" : "#44AFE0"
  json.size conn.weight.abs
end
