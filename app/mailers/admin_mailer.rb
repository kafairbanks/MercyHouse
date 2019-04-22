class AdminMailer < ApplicationMailer


    def applicant_submitted_email(applicant, application)
        @applicant = applicant
        @application = application
        @url = url_for(action: 'edit', controller: 'applicants', id: @applicant.id)
        mail(:to => 'mcnaughtonbr@tamu.edu', :subject => "New application notice.")
    end


    # If a red flagged applicant submits an application send a different email to the admin
    def applicant_redflag_notice(applicant, application)
        @applicant = applicant
        @application = application
        @url = url_for(action: 'edit', controller: 'applicants', id: @applicant.id)
        mail(:to => 'mcnaughtonbr@tamu.edu', :subject => "Red flagged application notice.")
    end

end
