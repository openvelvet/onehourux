class SessionsController < Devise::SessionsController
	before_filter :disable_nav, only: [:new]

  private

  def disable_nav
    @disable_nav = true
  end
  
end