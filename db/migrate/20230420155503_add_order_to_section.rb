class AddOrderToSection < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :order, :integer, null: false
  end
end
