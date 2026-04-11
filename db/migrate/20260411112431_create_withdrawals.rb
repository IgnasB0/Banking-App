class CreateWithdrawals < ActiveRecord::Migration[8.1]
  def change
    create_table :withdrawals do |t|
      t.references :banking_facility, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
