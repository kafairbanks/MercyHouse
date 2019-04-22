require 'rails_helper'

RSpec.describe ApplicantDashController, type: :controller do

  let(:valid_attributes) {{

  }}

  let(:valid_session) { {
      applicants_id: 1,
      user_role: '',
      user_id: 1,
  } }

  describe "GET #show_dash" do
    context "for returning applicant" do
      it "is successful" do
        get :show_dash, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    context "for new applicant" do
      it "redirects to new application" do
        new_applicant_params = {
            AName: 'Patient Smith',
            AMinor: false,
            AAge: 19,
            SPName: 'Parent Smith',
            SPHomePhone: '979-867-5309',
            AEmail: 'name@example.com'
        }
        new_applicant = Applicant.create!(new_applicant_params)
        valid_session2 = {
            applicants_id: Applicant.last.id,
            user_role: '',
            user_id: 1,
        }
        get :show_dash, params: {}, session: valid_session2
        expect(response).to redirect_to(new_application_path(applicants_id: new_applicant.id))
      end
    end
  end

end
