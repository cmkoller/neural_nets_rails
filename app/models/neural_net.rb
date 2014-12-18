class NeuralNet < ActiveRecord::Base
  has_many :nodes

  validates :name, length: {maximum: 255}
end
