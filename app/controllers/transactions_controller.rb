class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_iex_client
  rescue_from IEX::Errors::SymbolNotFoundError, with: :symbol_not_found

  def index
    @transactions =  current_user.transactions.order("created_at DESC").page params[:page]
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
    ActiveRecord::Base.transaction do 
      @transaction = current_user.transactions.build(transaction_params)
      @transaction.save
      update_portfolio
      update_wallet
      if @transaction.transaction_type == "BUY"
        if @balance
          redirect_to request.referrer, notice: "Insufficient balance to purchase #{@transaction.shares.to_i} #{@transaction.symbol} shares!"
          raise ActiveRecord::Rollback
        else
          redirect_to portfolio_index_path, notice: "Portfolio updated!"
        end
      elsif @transaction.transaction_type == "SELL"
        if @owned_stocks
          redirect_to request.referrer, notice: "Insufficient stocks to sell!"
          raise ActiveRecord::Rollback
        else
          redirect_to portfolio_index_path, notice: "Portfolio updated!"
        end
      end
    end
  end



  private
  def initialize_iex_client
    @client = IEX::Api::Client.new
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :symbol, :company_name, :shares, :cost_price, :transaction_type)
  end

  def symbol_not_found
    redirect_to home_index_path, notice: "Symbol not found"
  end

  def update_portfolio
    @user_portfolio = current_user.portfolios.find_by(symbol: @transaction.symbol)
    if @user_portfolio
      if @transaction.transaction_type == "BUY"
        stock_validation
      elsif @transaction.transaction_type == "SELL"
        sell_validation
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
      wallet_validation
    else
      @add_wallet = @user_wallet.amount + @transaction_total
      @user_wallet.update_attribute(:amount, @add_wallet)
    end
  end

  def wallet_validation
    @user_portfolio = current_user.portfolios.find_by(symbol: @transaction.symbol)
    @user_wallet = current_user.userwallets.find_by(user_id: current_user)
    @transaction_total = @transaction.shares * @transaction.cost_price
    @balance = @user_wallet.amount < @transaction_total
    if !@balance
      @deduct_wallet = @user_wallet.amount - @transaction_total
      @user_wallet.update_attribute(:amount, @deduct_wallet)
    end
  end

  def stock_validation
    @user_portfolio = current_user.portfolios.find_by(symbol: @transaction.symbol)
    @user_wallet = current_user.userwallets.find_by(user_id: current_user)
    @transaction_total = @transaction.shares * @transaction.cost_price
    @balance = @user_wallet.amount < @transaction_total
    if !@balance
      @update_stocks = @user_portfolio.shares + @transaction.shares
      @user_portfolio.update_attribute(:shares, @update_stocks)
    end
  end

  def sell_validation
    @user_portfolio = current_user.portfolios.find_by(symbol: @transaction.symbol)
    @user_wallet = current_user.userwallets.find_by(user_id: current_user)
    @owned_stocks = @user_portfolio.shares < @transaction.shares
    if !@owned_stocks
      @update_stocks = @user_portfolio.shares - @transaction.shares
      @user_portfolio.update_attribute(:shares, @update_stocks)
    end
  end
end
