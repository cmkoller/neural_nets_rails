class EditNodeOutput < ActiveRecord::Migration
  def change
    change_column :nodes, :output, :float, default: 0, null: false
  end
end
