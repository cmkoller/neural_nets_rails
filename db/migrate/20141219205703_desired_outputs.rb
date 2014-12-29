class DesiredOutputs < ActiveRecord::Migration
  def change
    create_table :desired_outputs do |t|
      t.belongs_to :neural_net
      t.belongs_to :preset_input
      t.string :name
      t.string :values
    end
  end
end
