class StaticPagesController < ApplicationController
  def home
  	redirect_to current_user if login?
  	@user = User.new
  end

  def about
  end

  def contact
  end
end
