class Node < ActiveRecord::Base
  belongs_to :neural_net
  has_many :child_connections, class_name: "Connection", foreign_key: "parent_id"
  has_many :parent_connections, class_name: "Connection", foreign_key: "child_id"
  has_many :parents, through: :parent_connections

  validates :neural_net_id,
    presence: true
  validates :layer,
    presence: true

    def active?
      if total_input >= 1
        "active"
      end
    end

end
