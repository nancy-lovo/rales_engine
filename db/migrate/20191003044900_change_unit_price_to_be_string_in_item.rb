class ChangeUnitPriceToBeStringInItem < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :unit_price, :string
  end
end
