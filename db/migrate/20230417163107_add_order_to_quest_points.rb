class AddOrderToQuestPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :quest_points, :order, :integer, null: false
  end
end
