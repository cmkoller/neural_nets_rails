class EditNodeTotalInput < ActiveRecord::Migration
  def change
    change_column :nodes, :total_input, :float, default: 0, null: false
  end
end
