class AddColumsToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
    add_column :orders, :notes, :string
    add_column :orders, :deliverydate, :datetime

    add_column :menus, :min_order, :integer
    add_column :menus, :description, :string
  end
end
