class AddTimestampsToNets < ActiveRecord::Migration
  def change
    add_column(:neural_nets, :created_at, :datetime)
    add_column(:neural_nets, :updated_at, :datetime)
  end
end
