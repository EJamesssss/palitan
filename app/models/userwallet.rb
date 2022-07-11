class Userwallet < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: {message: "wallet are already exist"}
  validates :amount, presence: true
end
