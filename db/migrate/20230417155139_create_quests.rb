class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :title
      t.text :description, null: true
      t.boolean :public, null: false, default: false

      t.timestamps
    end
  end
end
