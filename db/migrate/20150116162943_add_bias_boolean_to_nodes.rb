class AddBiasBooleanToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :bias, :boolean, default: false, null: false
  end
end
