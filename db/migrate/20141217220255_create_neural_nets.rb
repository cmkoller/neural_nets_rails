class CreateNeuralNets < ActiveRecord::Migration
  def change
    create_table :neural_nets do |t|
      t.string :name
    end
  end
end
