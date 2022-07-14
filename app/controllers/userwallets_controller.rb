class UserwalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_userwallet, only: [:show, :edit, :update, :destroy]

  # GET /userwallets
  def index
    @userwallets = current_user.userwallets
  end

  # GET /userwallets/1
  def show
  end

  # GET /userwallets/new
  def new
    @userwallet = Userwallet.new
  end

  # GET /userwallets/1/edit
  def edit
    @amount = Userwallet.find(params[:id])
  end

  # POST /userwallets
  def create
    @userwallet = Userwallet.new(userwallet_params)

    if @userwallet.save
      redirect_to portfolio_index_path, notice: 'Userwallet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /userwallets/1
  def update
    @amount = Userwallet.find(params[:id])
    @total = @amount.amount.to_f + userwallet_params[:amount].to_f
    if @amount.update_attribute(:amount, @total)
    redirect_to portfolio_index_path, notice: "#{userwallet_params[:amount].to_f} was successfull added to your wallet."
    else
      redirect_to request.referrer
    end
  end

  # DELETE /userwallets/1
  def destroy
    @userwallet.destroy
    redirect_to userwallets_url, notice: 'Userwallet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userwallet
      @userwallet = Userwallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def userwallet_params
      params.require(:userwallet).permit(:amount, :user_id)
    end
end
