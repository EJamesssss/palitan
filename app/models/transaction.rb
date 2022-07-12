class Transaction < ApplicationRecord
    belongs_to :user
    # before_save :transaction_validation

    # def transaction_validation
    #     user_wallet = Userwallets.find_by(id: current_user)
    #     portfolio = Portfolio.find_by(symbol: symbol, user_id: user_id)

    #     if user_wallet.amount < (shares * cost_price)
    #         errors.add(:base, 'Insufficient balance, please try again.')
    #         throw :abort
    #     end
    # end
end
