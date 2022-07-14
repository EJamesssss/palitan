class Portfolio < ApplicationRecord
    belongs_to :user
    has_many :transactions

    paginates_per 10
end
