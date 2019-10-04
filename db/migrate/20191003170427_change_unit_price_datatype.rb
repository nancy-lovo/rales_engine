class ChangeUnitPriceDatatype < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :unit_price, 'integer USING CAST(unit_price AS integer)'
    change_column :invoice_items, :unit_price, 'integer USING CAST(unit_price AS integer)'
  end
end
