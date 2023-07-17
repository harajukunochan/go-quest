class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :quest_points, :category_id, :section_id
  end
end
