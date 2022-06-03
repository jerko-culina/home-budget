class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.string :auth_token, null: false, unique: true
      t.integer :available_cents, null: false, default: 0

      t.timestamps
    end
  end
end
