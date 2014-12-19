class NeuralNet < ActiveRecord::Base
  has_many :nodes

  validates :name, length: {maximum: 255}

  # ====================
  # HELPER FUNCTIONS
  # ====================

  # LAYER_N_NODES
  # --------------------
  # Input: L, representing the layer number (0th layer is top layer)
  # Output: Array of nodes from that layer
  def layer_n_nodes(l)
    nodes.where(neural_net_id: id, layer: l).sort_by &:id
  end

  # NUM_LAYERS
  # --------------------
  # Output: Number of layers in NN
  def num_layers
    num_layers = 0
    while !nodes.where(neural_net_id: id, layer: num_layers).empty?
      num_layers += 1
    end
    num_layers
  end

  # FIRST_LAYER_NODES
  # --------------------
  def first_layer_nodes
    layer_n_nodes(0)
  end

  # LAST_LAYER_NODES
  # --------------------
  def last_layer_nodes
    layer_n_nodes(num_layers - 1)
  end

  # LOOP_OVER_NODES
  # --------------------
  # Input: L, representing layer number
  # => Additionally, takes in block representing what to do to each node
  def loop_over_nodes(l)
    layer_n_nodes(l).length.times do |i|
      yield i
    end
  end

  # ====================
  # CREATION/DELETION METHODS
  # ====================

  # CREATE_NODE
  # --------------------
  # Input: L, representing the layer number (0th layer is top layer)
  # Generates a new node on layer L with randomly weighted connections
  # to all nodes on layer above (if applicable) and below (if applicable)
  # Returns NODE
  def create_node(l)
    node = Node.create(neural_net_id: id, layer: l)
    # Unless L is first layer, generate upward connections
    unless l <= 0
      # For each parent node...
      loop_over_nodes(l - 1) do |i|
        parent = layer_n_nodes(l - 1)[i]
        # Generate a random connection weight between -1 and 1
        weight = rand * 2 - 1
        Connection.create(parent_id: parent.id,
        child_id: node.id,
        weight: weight.round(3))
      end
    end
    # Unless L is last layer, generate downward connections
    unless l >= num_layers - 1
      # For each child node...
      loop_over_nodes(l + 1) do |i|
        child = layer_n_nodes(l + 1)[i]
        # Generate a random connection weight between -1 and 1
        weight = rand * 2 - 1
        Connection.create(parent_id: node.id,
        child_id: child.id,
        weight: weight.round(3))
      end
    end
    node
  end

end
