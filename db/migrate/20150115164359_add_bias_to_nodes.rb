class AddBiasToNodes < ActiveRecord::Migration
  def up
    add_column :nodes, :bias, :float
    Node.all.each do |node|
      node.bias = (rand(75) + 25) / 100.0
      node.save
    end
    change_column_null :nodes, :bias, false
  end

  def down
    remove_column :nodes, :bias
  end
end
