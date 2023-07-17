class CreateQuestPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :quest_points do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: true

      t.timestamps
    end
  end
end
