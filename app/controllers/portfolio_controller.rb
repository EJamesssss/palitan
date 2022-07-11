class PortfolioController < ApplicationController
  before_action :authenticate_user!
    def index
      @portfolios = current_user.portfolios
      @wallets = current_user.userwallets
    end 
end
