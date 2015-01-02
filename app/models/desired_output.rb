class DesiredOutput < ActiveRecord::Base
  belongs_to :preset_input
  belongs_to :neural_net
  serialize :values
  
end
