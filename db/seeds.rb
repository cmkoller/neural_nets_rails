# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


net = NeuralNet.create({name: "Sample Net"})
2.times do
  Node.create({layer: 0, neural_net_id: net.id})
end
2.times do
  Node.create({layer: 1, neural_net_id: net.id})
end

preset_inputs = [
  {name: "T/T", values: "11"},
  {name: "T/F", values: "10"},
  {name: "F/T", values: "01"},
  {name: "F/F", values: "00"}
]

preset_inputs.each do |info|
  info[:neural_net_id] = net.id
  cur = PresetInput.create(info)
  info[:preset_input_id] = cur.id
  DesiredOutput.create(info)
end
