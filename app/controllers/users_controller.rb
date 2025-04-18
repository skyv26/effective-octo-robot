# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_superadmin!
    before_action :set_user, only: %i[edit update destroy]
  
    def index
      if current_user.superadmin?
        @users = User.where.not(id: current_user.id) # see all except self
      else
        @users = User.where.not(role: :superadmin)   # admins can't see superadmins
      end
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to users_path, notice: 'User created successfully.'
      else
        render :new
      end
    end
  
    def edit; end
  
    def update
      if @user.update(user_params)
        redirect_to users_path, notice: 'User updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_path, notice: 'User deleted.'
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      permitted = %i[name email password password_confirmation]
      permitted << :role if current_user.superadmin?
      params.require(:user).permit(permitted)
    end
  
    def authorize_admin_or_superadmin!
      redirect_to root_path, alert: 'Access denied.' unless current_user.admin? || current_user.superadmin?
    end
  end
  