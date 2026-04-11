class RenameDepsitorsToBankingFacilities < ActiveRecord::Migration[8.1]
  def change
    rename_table :depositors, :banking_facilities
  end
end
