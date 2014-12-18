class AddIndexToNodes < ActiveRecord::Migration
  def change
    add_index :nodes, :neural_net_id
  end
end
