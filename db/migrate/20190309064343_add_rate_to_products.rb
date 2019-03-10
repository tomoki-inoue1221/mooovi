class AddRateToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :Products, :director, :string
    add_column :Products, :detail, :text
    add_column :Products, :open_date, :string
  end
end
