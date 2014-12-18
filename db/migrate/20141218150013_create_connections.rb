class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :parent_id, null: false
      t.integer :child_id, null: false
      t.float :weight, null: false
    end
    add_index :connections, :parent_id
    add_index :connections, :child_id
  end
end
