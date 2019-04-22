class SessionsController < ApplicationController
    def create

        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        session[:user_name] = user.name
        session[:user_role] = user.role
        session[:finished_signin] = nil
        # Couple notes:
        # 1. An admin will be immediately redirected to the calendar (ideally should change to a dashboard or something)
        # 2. If it is a patient's first time logging in, then they will be redirected to a new applicant form
        #    - After they submit a new applicant form they will no longer be redirected to a new application but rather to their dashboard
        #    - If this is not their first time visiting the website and have already filled out the form then they go directly to the dashboard
        if session[:user_role] == "admin"
            redirect_to calendar_path # admin path to dashboard would go here
        elsif user.applicantid == -1
            redirect_to new_applicant_path
        else
            session[:finished_signin] = 1
            session[:applicants_id] = user.applicantid 
            redirect_to show_dash_path # goes to patient dashboard
        end
    end

    def destroy
        # session[:user_id] = nil
        # session[:user_name] = nil
        # session[:user_role] = nil
        reset_session
        redirect_to login_path # need to implement a logout button
    end

end