class PresetInput < ActiveRecord::Base
  has_one :desired_output
  belongs_to :neural_net
  serialize :values

  accepts_nested_attributes_for :desired_output
end
