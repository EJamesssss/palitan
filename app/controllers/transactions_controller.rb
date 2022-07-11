class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_iex_client

  def index
    @logs = Transaction.all.order("created_at DESC")
    @transactions =  current_user.transactions.order("created_at DESC")
  end


  def new
    @symbol = params[:symbol]
    @price = @client.quote(@symbol)
    @company = @client.company(@symbol)
    @logo = @client.logo(@symbol)
    @wallets = current_user.userwallets.find_by(user_id: current_user)
    @portfolio = current_user.portfolios.find_by(symbol: @symbol)
    if @portfolio == nil
      @user_shares = 0
    else
      @user_shares = @portfolio.shares
    end
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      update_portfolio
      update_wallet
      redirect_to portfolio_index_path, notice: "Portfolio updated!"
    else
      render :new
    end
  end



  private
  def initialize_iex_client
    @client = IEX::Api::Client.new
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :symbol, :company_name, :shares, :cost_price, :transaction_type)
  end

  def update_portfolio
    @user_portfolio = current_user.portfolios.find_by(symbol: @transaction.symbol)
    if @user_portfolio
      if @transaction.transaction_type == "BUY"
        @update_stocks = @user_portfolio.shares + @transaction.shares
        @user_portfolio.update_attribute(:shares, @update_stocks)
      else
        @update_stocks = @user_portfolio.shares - @transaction.shares
        @user_portfolio.update_attribute(:shares, @update_stocks)
      end
    else
      @portfolio = current_user.portfolios.build(params.require(:transaction).permit(:user_id, :symbol, :company_name, :shares, :cost_price))
      @portfolio.save
    end

  end

  def update_wallet
    @user_wallet = current_user.userwallets.find_by(user_id: current_user)
    @transaction_total = @transaction.shares * @transaction.cost_price
    if @transaction.transaction_type == "BUY"
      @deduct_wallet = @user_wallet.amount - @transaction_total
      @user_wallet.update_attribute(:amount, @deduct_wallet)
    else
      @add_wallet = @user_wallet.amount + @transaction_total
      @user_wallet.update_attribute(:amount, @add_wallet)
    end
  end


end
