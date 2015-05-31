class UsersController < ApplicationController
	before_action :authenticate_user!

	def additional_fields
		@user = User.find(params[:id])
	end
end
