class AddUserToAccounts < ActiveRecord::Migration[8.1]
  def change
    add_reference :accounts, :user, null: true, foreign_key: true
  end
end
