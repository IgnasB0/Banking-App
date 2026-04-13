class RenameTransactionsToTransfers < ActiveRecord::Migration[8.1]
  def change
    rename_table :transactions, :transfers
  end
end
