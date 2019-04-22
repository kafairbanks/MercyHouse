class AuthenticationController < ApplicationController

    before_action :authenticate_user
    helper_method :authenticate_user
    helper_method :is_admin

    def authenticate_user
        if !session[:user_id] then
            redirect_to '/'
        end
    end

    def is_admin
        if !(session[:user_role] == "admin") || session[:user_role].nil? then
            redirect_back fallback_location: show_dash_path, notice: "Error: Not authorized!" # These notices aren't showing.
        end
    end

    # Checks to make sure an applicant edits only their information, but lets admins change info also
    def is_correct_applicant
        if !(session[:applicants_id].to_i == params[:id].to_i) && !(session[:user_role] == "admin")
            redirect_back fallback_location: show_dash_path, notice: "Error: Not authorized!" # These notices aren't showing
        end
    end

    # Checks to make sure an applicantion is only viewed by the applicant that submitted it
    def is_correct_application
        if !(session[:applicants_id].to_i == @application.applicants_id) && !(session[:user_role] == "admin")
            redirect_back fallback_location: show_dash_path, notice: "Error: Not authorized!"
        end
    end

end
