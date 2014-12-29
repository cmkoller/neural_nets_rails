class PresetInputs < ActiveRecord::Migration
  def change
    create_table :preset_inputs do |t|
      t.belongs_to :neural_net
      t.string :name
      t.string :values
    end
  end
end
