class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :status_type, null: false
      t.string :role_type, null: false
      t.string :oauth_type, null: false
      t.string :sub

      t.timestamps
    end

    add_index :users, :uid, unique: true
    add_index :users, :email, unique: true
  end
end
