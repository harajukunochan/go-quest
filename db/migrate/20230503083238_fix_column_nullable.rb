class FixColumnNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :quest_points, :section_id, :integer, references: :section, null: true
  end
end
