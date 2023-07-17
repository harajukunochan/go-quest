class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :value, null: false
      t.string :browser
      t.string :platform
      t.date :last_use, null: false

      t.timestamps
    end

    add_index :tokens, :value
  end
end
