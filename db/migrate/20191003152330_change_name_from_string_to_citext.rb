class ChangeNameFromStringToCitext < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'
    
    change_column :customers, :first_name, :citext
    change_column :customers, :last_name, :citext

    change_column :items, :name, :citext
    change_column :items, :description, :citext

    change_column :merchants, :name, :citext

    change_column :transactions, :result, :citext
  end
end
