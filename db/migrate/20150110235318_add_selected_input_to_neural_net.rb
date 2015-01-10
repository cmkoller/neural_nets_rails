class AddSelectedInputToNeuralNet < ActiveRecord::Migration
  def change
    add_column :neural_nets, :selected_input_id, :integer
  end
end
