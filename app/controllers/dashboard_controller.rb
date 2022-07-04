class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin
  def index
    @registered_users = User.all
  end

  private
  def must_be_admin
    unless current_user.admin?
      redirect_to home_index_path, notice: "Restricted"
    end
  end

end
