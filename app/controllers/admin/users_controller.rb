class Admin::UsersController < ApplicationController
    before_action :must_be_admin
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
    end


    def new 
        @user = User.new
    end

    
    def create
        @user = User.create(user_params)
        @approved = @user.approved

        if @user.save
            if @approved
                UnapprovedMailer.with(user: @user).user_approved.deliver_later
            end
            redirect_to admin_users_path, notice: "Successfully created #{@user.email}"
        else
            render :new
        end
    end

    def edit
    end

    def update
        with_password = params[:user][:password].blank? ? "update_without_password" : "update"
        if @user.send(with_password, user_params)
            redirect_to admin_users_path, notice: "Update successful"
        else
            render :edit
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

    def destroy
        @user.destroy
        redirect_to admin_users_path, notice: "Deleted #{@user.email}"
    end

    private
    def must_be_admin
      unless current_user.admin?
        redirect_to home_index_path, notice: "Restricted"
      end
    end

    def set_user
        @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :approved)
    end
end
