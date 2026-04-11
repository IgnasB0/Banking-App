class AddIbanToAccounts < ActiveRecord::Migration[8.1]
  def change
    add_column :accounts, :iban, :string
    add_index :accounts, :iban, unique: true
  end
end
