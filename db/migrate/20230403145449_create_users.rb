class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.text :description, null: true
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
