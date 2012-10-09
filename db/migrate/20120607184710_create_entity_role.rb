class CreateEntityRole < ActiveRecord::Migration
  def up
    create_table "entity_roles", :force => true do |t|
      t.integer "entity_id"
      t.integer "role_id"
    end
    add_index "entity_roles", ["entity_id", "role_id"], :name => "index_entity_roles_on_entity_id_and_role_id", :unique => true

    add_foreign_key "entity_roles", "entities", :name => "entity_roles_entity_id_fkey"
    add_foreign_key "entity_roles", "roles", :name => "entity_roles_role_id_fkey"

    pub = Role.find_or_create_by_name('Public')
    User.all.each do |u|
      u.roles << pub
    end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
    drop_table "entity_roles"
  end
end
