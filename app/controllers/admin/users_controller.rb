class Admin::UsersController < ApplicationController
    before_action :must_be_admin

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
