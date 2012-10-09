class CreateEntityUser < ActiveRecord::Migration
  def up
    create_table "entity_users", :force => true do |t|
      t.integer "entity_id"
      t.integer "user_id"
    end
    add_index "entity_users", ["entity_id", "user_id"], :name => "index_entity_user_on_entity_id_and_user_id", :unique => true

    add_foreign_key "entity_users", "entities", :name => "entity_users_entity_id_fkey"
    add_foreign_key "entity_users", "users", :name => "entity_users_user_id_fkey"

  end

  def down
    raise ActiveRecord::IrreversibleMigration
    drop_table "entity_users"
  end
end
