class Trader::TransactionsController < ApplicationController
  before_action :initialize_iex_client

  def index
  end

  def show

  end

  def new
    @price = @client.quote(params[:symbol])
    @company = @client.company(params[:symbol])
    @logo = @client.logo(params[:symbol])
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    byebug
    if @transaction.save
      redirect_to portfolio_index_path
    else
      render :new
    end
  end

  private
  def initialize_iex_client
    @client = IEX::Api::Client.new
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :symbol, :company_name, :shares, :cost_price, :total, :transaction_type)
  end
end
