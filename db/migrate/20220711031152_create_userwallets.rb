class CreateUserwallets < ActiveRecord::Migration[6.1]
  def change
    create_table :userwallets do |t|
      t.float :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
