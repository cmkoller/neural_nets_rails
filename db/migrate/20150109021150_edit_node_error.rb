class EditNodeError < ActiveRecord::Migration
  def change
    change_column :nodes, :error, :float, default: 0, null: false    
  end
end
