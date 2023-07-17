class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :quest, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: true

      t.timestamps
    end
  end
end
