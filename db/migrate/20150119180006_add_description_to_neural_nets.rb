class AddDescriptionToNeuralNets < ActiveRecord::Migration
  def change
    add_column :neural_nets, :description, :text
  end
end
