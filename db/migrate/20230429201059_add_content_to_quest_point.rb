class AddContentToQuestPoint < ActiveRecord::Migration[7.0]
  def change
    add_column :quest_points, :content, :text
  end
end
