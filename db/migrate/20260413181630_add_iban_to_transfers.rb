class AddIbanToTransfers < ActiveRecord::Migration[8.1]
  def change
    add_column :transfers, :sender_iban, :string
    add_column :transfers, :receiver_iban, :string
  end
end
