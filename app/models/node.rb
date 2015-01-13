class Node < ActiveRecord::Base
  belongs_to :neural_net
  has_many :child_connections, class_name: "Connection", foreign_key: "parent_id"
  has_many :parent_connections, class_name: "Connection", foreign_key: "child_id"
  has_many :parents, through: :parent_connections

  validates :neural_net_id,
    presence: true
  validates :layer,
    presence: true

  after_initialize :init


  # =========================
  # SERVING FOR SIGMA.JS
  # =========================

  def to_builder
    JBuilder.new do |node|
      node.id id
      node.layer "LAYERRRR"
    end
  end

  # ---------------------------------------------------------

  def init
    self.total_input ||= 0.0
  end

  def active?
    if total_input >= 1
      "active"
    end
  end

  # SIGMOID
  # One possible function for determining output
  def sigmoid(x)
    1 / (1 + (Math::E ** (-1 * x)))
  end

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

  def update_output_node_error(desired)
    write_attribute(:error, output * (1 - output) * (desired - output))
    save
  end

  def update_middle_node_error()
    desired = get_middle_desired_output
    write_attribute(:error,  output * (1 - output) * desired)
    save
    binding.pry
  end

  # UPDATE_PARENT_CONNECTIONS
  # -------------------
  def update_parent_connections(alpha)
    parent_connections.each do |conn|
      parent = Node.find(conn.parent_id)
      # binding.pry
      conn.weight += alpha * parent.output * error
      conn.save
    end
  end

end
