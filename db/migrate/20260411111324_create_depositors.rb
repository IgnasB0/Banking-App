class CreateDepositors < ActiveRecord::Migration[8.1]
  def change
    create_table :depositors do |t|
      t.string :name
      t.string :api_key_digest

      t.timestamps
    end
  end
end
