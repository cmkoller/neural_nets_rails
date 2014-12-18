class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :layer, default: 0, null: false
      t.integer :neural_net_id, null: false
    end
  end
end
