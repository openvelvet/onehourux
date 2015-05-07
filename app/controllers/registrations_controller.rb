class RegistrationsController < Devise::RegistrationsController
  
  
  
  protected

  def after_sign_up_path_for(resource)
    '/profiles/new'
  end

  def update_resource(resource, params)
    if current_user.provider == "linkedin"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end