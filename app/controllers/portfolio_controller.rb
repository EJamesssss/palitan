class PortfolioController < ApplicationController
  before_action :authenticate_user!
    def index
      @portfolios = current_user.portfolios.page params[:page]
      @wallets = current_user.userwallets.find_by(user_id: current_user)
    end 
end
