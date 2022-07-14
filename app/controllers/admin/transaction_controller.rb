class Admin::TransactionController < ApplicationController
  def index
    @transactions = Transaction.all.order("created_at DESC").page params[:page]
  end
end
