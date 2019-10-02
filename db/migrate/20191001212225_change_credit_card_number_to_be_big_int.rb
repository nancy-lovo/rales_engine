class ChangeCreditCardNumberToBeBigInt < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :credit_card_number, :bigint
  end
end
