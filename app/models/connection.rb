class Connection < ActiveRecord::Base
  belongs_to :parent, class_name: "Node"
  belongs_to :child, class_name: "Node"

  validates :parent_id,
    presence: true
  validates :child_id,
    presence: true
  validates :weight,
    presence: true
end
