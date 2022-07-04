class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin
  def index
    @registered_users = User.all
  end

  def show
    @registered_users = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
        redirect_to dashboard_index_path
    else
        render :new
    end
  end

  def edit
  end

  def update
    # if @trader.update(trader_params)
    #   # User.send_approved_email(params[:email])
    #   send_approved_email(@trader)
    #   redirect_to admin_user_path(@trader)
    # else
    #     render :edit
    # end
  end


  def pending_users
    @unapproved = User.where("approved = ?", false)
  end

  def approved
    @unapproved = User.find(params[:id])
    if @unapproved.update_attribute(:approved, true)
      UnapprovedMailer.with(user: @unapproved).user_approved.deliver_later
      redirect_to dashboard_path, notice: "User information has been updated"
    else
      redirect_to pending_users_path, notice: "Approval of user failed!"
    end
  end

  private
  def must_be_admin
    unless current_user.admin?
      redirect_to home_index_path, notice: "Restricted"
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :approved)
  end

end
