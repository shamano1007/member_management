class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, null: false, after: :login_id
    add_column :users, :name, :string, after: :remember_created_at
  end
end
