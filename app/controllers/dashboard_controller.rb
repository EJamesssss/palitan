class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin
  def index
    @registered_users = User.all
  end

  def show
    @registered_users = User.find(params[:id])
  end


  def pending_users
    @unapproved = User.where("approved = ?", false)
  end

  def update
    @unapproved = User.find(params[:id])
    if @unapproved.update_attribute(:approved, true)
      redirect_to dashboard_path, notice: "User information has been updated"
    end
  end

  private
  def must_be_admin
    unless current_user.admin?
      redirect_to home_index_path, notice: "Restricted"
    end
  end

end
