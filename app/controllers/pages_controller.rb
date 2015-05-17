class PagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  	@cuntact = params[:funky]
  end
end
