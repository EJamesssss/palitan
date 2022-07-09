class RemoveTotalFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :total, :float
  end
end
