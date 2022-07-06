class PortfolioController < ApplicationController
    def index
        @portfolios = current_user.portfolios
    end 
    
    private
  
    def set_user
      @user = current_user
    end
end
