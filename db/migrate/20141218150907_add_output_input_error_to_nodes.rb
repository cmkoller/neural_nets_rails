class AddOutputInputErrorToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :output, :integer, :default => 0
    add_column :nodes, :total_input, :integer, :default => 0
    add_column :nodes, :error, :integer
  end
end
