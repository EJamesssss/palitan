class DropOldWalletsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.float :balance

      t.timestamps
    end
  end
end
