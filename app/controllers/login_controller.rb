class LoginController < ApplicationController

  before_action :is_logged_in

  def login
  end

  private

  # if there is someone logged in it takes them to the appropriate landing page
  def is_logged_in
    
    if !session[:user_id].nil?
      if session[:user_role] == "admin"
        redirect_to '/calendar'
      elsif session[:user_role] == "user"
        redirect_to show_dash_path
      else 
        # puts("Going to login page")
      end
    end

  end

end
