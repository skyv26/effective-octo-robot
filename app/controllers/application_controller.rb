class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout 'application'  # Default for all actions, including Devise

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
