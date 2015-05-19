class PagesController < ApplicationController
  
  def home
  end

  def about
  	@foot = params[:multiple].to_i * 2
  end

  def contact
  	@cuntact = params[:funky]
  end

  def type
  end
end
