class Trader::TransactionsController < ApplicationController
  def index
  end

  def show
    @price = Client.quote(params[:symbol])
    @company = Client.company(params[:symbol])
    @logo = Client.logo(params[:symbol])
  end

  def new
  end

  def create
  end
end
