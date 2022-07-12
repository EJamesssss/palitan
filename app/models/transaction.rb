class Transaction < ApplicationRecord
    belongs_to :user
    paginates_per 25
end
