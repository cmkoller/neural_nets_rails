# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150115164359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: true do |t|
    t.integer "parent_id", null: false
    t.integer "child_id",  null: false
    t.float   "weight",    null: false
  end

  add_index "connections", ["child_id"], name: "index_connections_on_child_id", using: :btree
  add_index "connections", ["parent_id"], name: "index_connections_on_parent_id", using: :btree

  create_table "desired_outputs", force: true do |t|
    t.integer "neural_net_id"
    t.integer "preset_input_id"
    t.string  "name"
    t.string  "values"
  end

  create_table "neural_nets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_input_id"
  end

  create_table "nodes", force: true do |t|
    t.integer "layer",         default: 0,   null: false
    t.integer "neural_net_id",               null: false
    t.float   "output",        default: 0.0, null: false
    t.float   "total_input",   default: 0.0, null: false
    t.float   "error",         default: 0.0, null: false
    t.float   "bias",                        null: false
  end

  add_index "nodes", ["neural_net_id"], name: "index_nodes_on_neural_net_id", using: :btree

  create_table "preset_inputs", force: true do |t|
    t.integer "neural_net_id"
    t.string  "name"
    t.string  "values"
  end

end
