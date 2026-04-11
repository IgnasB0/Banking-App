class AddCountryCodeToAccounts < ActiveRecord::Migration[8.1]
  def change
    add_column :accounts, :country_code, :string
  end
end
