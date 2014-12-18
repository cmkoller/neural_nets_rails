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


end
