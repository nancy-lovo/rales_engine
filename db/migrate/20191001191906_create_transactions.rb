class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.integer :credit_card_number
      t.integer :credit_card_expiration_date, default: nil
      t.string :result

      t.timestamps
    end
  end
end
