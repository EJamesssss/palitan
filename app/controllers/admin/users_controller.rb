class Admin::UsersController < ApplicationController
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
            redirect_to admin_users_path
            if @user.approved = true
                UnapprovedMailer.with(user: @user).user_approved.deliver_later
            end
        else
            render :new
        end
    end

    def pending_users
        @unapproved = User.where("approved = ?", false)
    end
    
    def approved
        @unapproved = User.find(params[:id])
        if @unapproved.update_attribute(:approved, true)
          UnapprovedMailer.with(user: @unapproved).user_approved.deliver_later
          redirect_to admin_users_path, notice: "User information has been updated"
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
