class RemoveTotalFromPortfolios < ActiveRecord::Migration[6.1]
  def change
    remove_column :portfolios, :total, :float
  end
end
