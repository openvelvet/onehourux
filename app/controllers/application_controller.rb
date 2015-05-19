class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation


  def after_sign_in_path_for(resource)
      if current_user.profile.nil?
        flash[:alert] = "Please complete your profile"
        new_profile_path
      else
        # Routing to the profile-URI
        # profile_path(:id => current_user.profile_uri)
        profile_path(current_user.profile)
      end
  end
  
  def after_sign_up_path_for(resource)
    if current_user.connections.nil?
      '/recruiters/new'
    else
      "/profiles/new"
    end
  end

  private
  
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :headline, :industry, :connections, :location, :summary, :linkedin_url, :linkedin_photo_url, :linkedin_position]
    devise_parameter_sanitizer.for(:account_update) << [:image]
  end
end
