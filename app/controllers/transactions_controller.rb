class TransactionsController < ApplicationController
  before_action :initialize_iex_client

  def index
    @transactions =  current_user.transactions
  end


  def new
    @symbol = params[:symbol]
    @price = @client.quote(@symbol)
    @company = @client.company(@symbol)
    @logo = @client.logo(@symbol)
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      redirect_to portfolio_index_path, noteice: "Asset added to portfolio!"
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
