class SettingController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!

  def index
    if current_user.superadmin?
      @users = User.all
    elsif current_user.admin?
      @users = User.where.not(role: 'superadmin')  # Exclude superadmins for admins
    else
      @users = [current_user]
    end
  end
end
