class Node < ActiveRecord::Base
  default_scope { order('id ASC') }
  belongs_to :neural_net, inverse_of: :nodes
  has_many :child_connections, class_name: "Connection", foreign_key: "parent_id"
  has_many :parent_connections, class_name: "Connection", foreign_key: "child_id"
  has_many :parents, through: :parent_connections

  validates :neural_net,
    presence: true
  validates :layer,
    presence: true

  THRESHOLD = 0

  after_initialize :init

  def init
    self.total_input ||= 0.0
  end

  def active?
    if output >= 1 || total_input >= 1
      "active"
    end
  end

  # ============================
  # ACTIVATION FUNCTIONS
  # ============================

  # SIGMOID
  # --------------------
  # One possible function for determining output
  def sigmoid(x)
    1 / (1 + (Math::E ** (-1 * x)))
  end

  # STEP FUNCTION
  # --------------------
  def step(x)
    x >= 0 ? 1 : 0
  end

  # ============================
  # HELPER FUNCTIONS FOR FF/BP
  # ============================

  # UPDATE_OUTPUT
  # -------------------
  # Uses total input, threshold, and sigmoid function to update output value
  def update_output
    write_attribute(:output, sigmoid(total_input).round(4))
    save
  end

  # SEND_OUTPUT_TO_CHILDREN
  # -------------------
  def send_output_to_children
    child_connections.each do |conn|
      child = Node.find(conn.child_id)
      child.total_input += output * conn.weight
      child.save
    end
  end


  # GET_MIDDLE_DESIRED_OUTPUT
  # -------------------
  # Calculates desired output of middle nodes based on error of child nodes
  # Desired Output = SUM( m(i) * p(i) )
  # => m(i) -- connection weight of current node to child
  # => p(i) -- error of child node
  def get_middle_desired_output
    desired = 0
    child_connections.each do |conn|
      weight = conn.weight
      child_error = Node.find(conn.child_id).error
      desired += child_error * weight
    end
    desired
  end

  def output_node_error(desired)
    output * (1 - output) * (desired - output)
  end

  def middle_node_error
    output * (1 - output) * get_middle_desired_output
  end

  def update_output_node_error(desired)
    write_attribute(:error, output_node_error(desired))
    save
  end

  def update_middle_node_error
    write_attribute(:error, middle_node_error)
    save
  end

  # UPDATE_PARENT_CONNECTIONS
  # -------------------
  def update_parent_connections(alpha)
    parent_connections.each do |conn|
      parent = Node.find(conn.parent_id)
      delta = alpha * (parent.output * conn.weight) * error
      puts "Updating Parent Weight -- Child: #{id}, Parent: #{parent.id}"
      puts "Parent Output: #{parent.output}"
      puts "Parent Output * Conn Weight: #{parent.output * conn.weight}"
      puts "Delta: #{delta}"
      conn.weight += delta.round(3)
      conn.save
    end
  end

end
