# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_superadmin!, except: %i[edit_profile update_profile] # Allow these actions for regular users
    before_action :set_user, only: %i[update destroy]
  
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
  
    def edit_profile
        @user = current_user
    end

    def update_profile
        @user = current_user
        
        raw_params = params[:user] || {}
        
        if raw_params[:password].blank? && raw_params[:password_confirmation].blank?
            update_params = raw_params.except(:password, :password_confirmation)
        else
            update_params = raw_params
        end
        
        # Safely permit based on user role
        permitted = %i[name phone address password password_confirmation]
        update_params = update_params.permit(permitted)
        
        if @user.update(update_params)
            flash.now[:notice] = "Profile updated successfully."
            respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash") }
            format.html { redirect_to edit_profile_path, notice: "Profile updated successfully." }
            end
        else
            render :edit_profile, status: :unprocessable_entity
        end
    end
      
    def update
      if @user.update(user_params)
        redirect_to users_path, notice: 'User updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
        @user.destroy
        flash.now[:notice] = "Profile deleted successfully."
      
        respond_to do |format|
          format.turbo_stream do
            # Turbo Stream to remove the user from the table
            render turbo_stream: [
                turbo_stream.remove(@user),
                turbo_stream.update("flash-message", partial: "shared/flash")
            ]
          end
          format.html { redirect_to users_path, notice: 'User deleted.' }
        end
    end
      
  
    private
  
    def set_user
        @user = User.find(params[:id]) unless action_name == 'edit_profile' || action_name == 'update_profile'
    end
  
    def user_params
        permitted = %i[name email phone_number address profile_photo password password_confirmation]
        permitted << :role if current_user.superadmin? # for admin use
        params.require(:user).permit(permitted)
      end
  
    def authorize_admin_or_superadmin!
      redirect_to root_path, alert: 'Access denied.' unless current_user.admin? || current_user.superadmin?
    end
  end
  