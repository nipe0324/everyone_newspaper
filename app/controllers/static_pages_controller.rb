class StaticPagesController < ApplicationController
  def home
  	redirect_to current_user if login?
  end

  def about
  end

  def contact
  end
end
