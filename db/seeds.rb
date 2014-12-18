# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

12.times do |n|
  # Make names more complex later
  net = NeuralNet.create({name: "Net#{n}"})
  43.times do
    Node.create({layer: rand(3), neural_net_id: net.id})
  end
end
