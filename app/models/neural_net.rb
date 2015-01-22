class NeuralNet < ActiveRecord::Base
  has_many :nodes, inverse_of: :neural_net
  has_many :preset_inputs
  has_many :desired_outputs
  # has_one :selected_input, class_name: "PresetInput"
  attr_accessor :times, :input, :output, :generate_bias

  validates :name, length: {maximum: 255}
  # validates_presence_of :nodes

  # Small constant regulating speed of learning
  ALPHA = 0.2

  accepts_nested_attributes_for :nodes

  # after_filter :init, only: :create

  def init
    # if self.new_record?
      nodes.each do |node|
        # Unless L is first layer, generate upwards connections
        # unless node.layer <= 0
        #   generate_parent_connections(node)
        # end

        # Unless L is last layer, generate downward connections
        unless node.layer >= num_layers - 1
          binding.pry
          generate_child_connections(node)
        end
      end
    # end
  end

  # =======================================
  # HELPER FUNCTIONS - Additional Getters
  # =======================================

  def selected_input
    if selected_input_id
      preset_inputs.find(selected_input_id)
    end
  end

  def selected_output
    if selected_input_id
      selected_input.desired_output
    end
  end

  def connections
    conns = []
    nodes.each do |node|
      conns += node.child_connections
    end
    conns
  end

  # =======================================
  # HELPER FUNCTIONS - Navigation of net
  # =======================================

  # LAYER_N_NODES
  # --------------------
  # Input: L, representing the layer number (0th layer is top layer)
  # Output: Array of nodes from that layer
  def layer_n_nodes(l)
    nodes.where(neural_net_id: id, layer: l)
  end

  # NONBIAS_LAYER_N_NODES
  # --------------------
  # Input: L, representing the layer number (0th layer is top layer)
  # Output: Array of nodes from that layer, excluding bias nodes
  def nonbias_layer_n_nodes(l)
    nodes.where(neural_net_id: id, layer: l, bias: false)
  end

  # NUM_LAYERS
  # --------------------
  # Output: Number of layers in NN
  def num_layers
    layers = nodes.map { |n| n.layer }
    layers.max + 1
  end

  # FIRST_LAYER_NODES
  # --------------------
  def first_layer_nodes
    layer_n_nodes(0)
  end

  # NONBIAS_FIRST_LAYER_NODES
  # --------------------
  def first_layer_nodes
    nonbias_layer_n_nodes(0)
  end

  # FIRST_LAYER_SIZE
  # --------------------
  def first_layer_size
    first_layer_nodes.length
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

  # REVERSE_LOOP_OVER_LAYERS
  # --------------------
  # Loops in over layers in reverse
  # => Takes in a block to execute code on layer index
  def reverse_loop_over_layers
    (num_layers - 1).downto(0).each do |l|
      yield l
    end
  end

  # GET_OUTPUTS
  # --------------------
  # Returns an array of outputs from output layer of net
  def get_outputs
    outputs = []
    last_layer_nodes = layer_n_nodes(num_layers - 1)
    loop_over_nodes(num_layers - 1) do |i|
      outputs << last_layer_nodes[i].output
    end
    outputs
  end

  # ====================
  # CREATION/DELETION METHODS
  # ====================

  # GENERATE_CHILD_CONNECTIONS
  # -----------------------------
  # Input: NODE, a node
  # Generates randomly weighted connections from NODE to
  # each node on the layer below.
  def generate_child_connections(node)
    l = node.layer
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

  # GENERATE_PARENT_CONNECTIONS
  # -----------------------------
  # Input: NODE, a node
  # Generates randomly weighted connections from NODE to
  # each node on the layer above.
  def generate_parent_connections(node)
    l = node.layer
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

  # CREATE_NODE
  # --------------------
  # Input: L, representing the layer number (0th layer is top layer)
  # => Generates a new node on layer L with randomly weighted connections
  # to all nodes on layer above (if applicable) and below (if applicable)
  # => If there is not yet a bias node on that layer, add a bias node
  # => Returns NODE
  def create_node(l)
    node = Node.create(neural_net_id: id, layer: l)
    # Unless L is first layer, generate upward connections
    unless l <= 0
      generate_parent_connections(node)
    end
    # Unless L is last layer, generate downward connections
    unless l >= num_layers - 1
      generate_child_connections(node)
    end
    node
  end

  # ----------------------
  # BIAS NODE MANAGEMENT
  # ----------------------

  # BIAS_NODE?
  # --------------------
  # Input: L, represeting the layer number
  # Checks to see if there is an existing bias node on the layer
  def bias_node?(l)
    layer_n_nodes(l).any? { |node| node.bias }
  end

  # CREATE_BIAS_NODE
  # --------------------
  # Input: L, representing the layer number
  # => Generates a bias node on layer L with randomly weighted connections
  # to all nodes on layer below.
  # => Returns node
  def create_bias_node(l)
    Node.create(neural_net_id: NeuralNet.last.id + 1, layer: l, bias: true, output: 1)
  end

  # GENERATE_BIAS
  # --------------------
  # To be called when node adding and subtracting is complete.
  # Generates a bias node for each non-output layer, each connected
  # to all nodes below but none above.
  def generate_bias=(x)
    binding.pry
    # For each layer except the output...
    (num_layers - 1).times do |l|
      # Unless there's already a bias node...
      unless bias_node?(l)
        node = create_bias_node(l)
        generate_child_connections(node)
        binding.pry
      end
    end
  end

  # ============================
  # FUNCTIONS FOR RUNNING NET
  # ============================

  def input=(id)
    self.selected_input_id = id
    save
    feed_forward(selected_input.values.values)
  end

  def output=(id)
    self.selected_input_id = nil
    save
    desired_output = desired_outputs.find(id)
    backprop(desired_output.values.values)
  end

  def times=(x)
    train(x.to_i)
  end


  # ====================
  # FEED FORWARD
  # ====================

  # RESET_ALL_NODES
  # --------------------
  # Resets all OUTPUT and TOTAL_INPUT fields to 0
  def reset_all_nodes
    NeuralNet.find(id).nodes.each do |node|
      unless node.bias
        node.output = 0.0
        node.total_input = 0.0
        node.save
      end
    end
  end

  # FEED_FORWARD
  # --------------------
  # Input: Array of values between 0 and 1 (inclusive).
  # => Array must be same length as first layer of nodes

  def feed_forward(input)
    puts "-------------------------"
    puts "FEED FORWARD"
    puts "-------------------------"
    reset_all_nodes
    # Check for wrong number of inputs
    unless input.length == first_layer_nodes.length
      return "ERROR - wrong number of inputs."
    end

    # Pass input values to first layer of nodes
    first_layer_nodes.length.times do |i|
      node = first_layer_nodes[i]
      node.output = input[i]
      node.save
    end

    # For each layer but the last, pass activation down
    (num_layers - 1).times do |layer_num|
      puts "Layer #{layer_num}"
      puts "---------------------------"
      cur_layer_nodes = layer_n_nodes(layer_num)
      # For each node in this layer, use the total input to calculate the output
      loop_over_nodes(layer_num) do |i|
        node = cur_layer_nodes[i]
        unless layer_num == 0
          node.update_output
        end
        puts "Node #{node.id} total input: #{node.total_input}"
        puts "Node #{node.id} output: #{node.output}"
        #For each child of this node, add to that node's total input
        node.send_output_to_children
      end
    end

    # Once we've fed forward to the last layer, calculate last layer's output
    puts "Output Layer"
    puts "---------------------------"
    loop_over_nodes(num_layers - 1) do |i|
      node = last_layer_nodes[i]
      node.update_output
      puts "Node #{node.id} total input: #{node.total_input}"
      puts "Node #{node.id} output: #{node.output}"
    end
  end

  # ====================
  # BACK PROPAGATION
  # ====================

  # BACK_PROP
  # --------------------
  # Input: Array of values between 0 and 1 (inclusive) representing desired output.
  # => Array must be same length as output layer of nodes

  def backprop(desired)
    puts "-------------------------"
    puts "BACKPROP"
    puts "-------------------------"
    # Calculate error for output layer nodes
    puts "Output Layer"
    puts "----------------------"
    puts "Desired Outputs: #{desired}"
    loop_over_nodes(num_layers - 1) do |i|
      node = last_layer_nodes[i]
      puts "Node: #{node.id}"
      current_desired = desired[i].to_i
      puts "Desired: #{current_desired}"
      node.update_output_node_error(current_desired)
      puts "Node #{node.id} desired output: #{current_desired}"
      puts "Node #{node.id} actual output: #{node.output}"
      puts "Node #{node.id} error: #{node.error}"
      # Update connections with that node's parents
      node.update_parent_connections(ALPHA)
    end

    # Move upwards through layers
    reverse_loop_over_layers do |l|
      # Only execute for middle nodes...
      # So if we're at an input or output layer, skip
      if l == 0 || l == num_layers - 1
        puts "Skipping some code - not a middle layer!"
        next
      end
      puts "*********************************"
      puts "*********************************"
      puts "We're at a middle layer!"
      puts "*********************************"
      puts "*********************************"
      cur_layer_nodes = layer_n_nodes(l)
      # Loop over each node in layer
      loop_over_nodes(l) do |i|
        node = cur_layer_nodes[i]
        node.update_middle_node_error

        # Update connections with that node's parents
        node.update_parent_connections(ALPHA)
      end
    end
  end

  # ====================
  # TRAIN X TIMES
  # ====================

  # TRAIN
  # --------------------
  # Input: Integer representing the number of trainings to run
  # => Runs X trainings on NN, each of which involves a feed-forward/back-prop
  # => pairing using one of the preset input/output pairings.


  def train(x)
    x.times do |i|
      input = preset_inputs[i % preset_inputs.length]
      feed_forward(input.values.values)
      output = input.desired_output
      backprop(output.values.values)
    end
  end

end
