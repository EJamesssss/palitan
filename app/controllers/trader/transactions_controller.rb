class Trader::TransactionsController < ApplicationController
  before_action :initialize_iex_client

  def index
  end

  def show
    @price = @client.quote(params[:logo])
    @company = @client.company(params[:logo])
    @logo = @client.logo(params[:logo])
  end

  def new
  end

  def create
  end

  private
  def initialize_iex_client
    @client = IEX::Api::Client.new
  end
end
