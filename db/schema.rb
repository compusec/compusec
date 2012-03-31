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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120309095325) do

  create_table "chairs", :force => true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chairs", ["faculty_id"], :name => "index_chairs_on_faculty_id"

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "logs", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "logs", ["user_id"], :name => "index_logs_on_user_id"

  create_table "military_ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scientific_ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.boolean  "activated"
    t.boolean  "banned"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.integer  "sex_id"
    t.integer  "chair_id"
    t.integer  "military_rank_id"
    t.integer  "scientific_rank_id"
    t.integer  "post_id"
    t.string   "phone"
    t.string   "room"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["chair_id"], :name => "index_users_on_chair_id"
  add_index "users", ["military_rank_id"], :name => "index_users_on_military_rank_id"
  add_index "users", ["post_id"], :name => "index_users_on_post_id"
  add_index "users", ["scientific_rank_id"], :name => "index_users_on_scientific_rank_id"
  add_index "users", ["sex_id"], :name => "index_users_on_sex_id"

end
