class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :symbol
      t.string :company_name
      t.float :shares
      t.float :cost_price
      t.float :total

      t.timestamps
    end
  end
end
