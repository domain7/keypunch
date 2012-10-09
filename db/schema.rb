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

ActiveRecord::Schema.define(:version => 20120710231044) do

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password",            :limit => 1000
    t.text     "description"
    t.string   "protocol"
    t.string   "domain"
    t.datetime "expire_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "password_changed_at"
  end

  create_table "entity_groups", :force => true do |t|
    t.integer "entity_id"
    t.integer "group_id"
  end

  add_index "entity_groups", ["entity_id", "group_id"], :name => "index_entity_groups_on_entity_id_and_group_id"

  create_table "entity_roles", :force => true do |t|
    t.integer "entity_id"
    t.integer "role_id"
  end

  add_index "entity_roles", ["entity_id", "role_id"], :name => "index_entity_roles_on_entity_id_and_role_id", :unique => true

  create_table "entity_users", :force => true do |t|
    t.integer "entity_id"
    t.integer "user_id"
  end

  add_index "entity_users", ["entity_id", "user_id"], :name => "index_entity_user_on_entity_id_and_user_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "password_histories", :force => true do |t|
    t.integer  "uniqueable_id"
    t.string   "uniqueable_type"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pgp_keys", :force => true do |t|
    t.binary   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  add_foreign_key "entity_groups", "entities", :name => "entity_groups_entity_id_fkey"
  add_foreign_key "entity_groups", "groups", :name => "entity_groups_group_id_fkey"

  add_foreign_key "entity_roles", "entities", :name => "entity_roles_entity_id_fkey"
  add_foreign_key "entity_roles", "roles", :name => "entity_roles_role_id_fkey"

  add_foreign_key "entity_users", "entities", :name => "entity_users_entity_id_fkey"
  add_foreign_key "entity_users", "users", :name => "entity_users_user_id_fkey"

end
