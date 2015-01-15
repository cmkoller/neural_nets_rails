class DeleteBiasFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :bias
  end
end
