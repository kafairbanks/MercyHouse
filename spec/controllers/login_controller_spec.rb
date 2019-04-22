require 'rails_helper'

RSpec.describe LoginController, type: :controller do


  let(:admin_session) { {
      user_id: 1,
      user_role: 'admin'
  } }

  let(:user_session) { {
      user_id: 7,
      user_role: 'user'
  } }

  let(:logout_session) { {
      user_id: 3,
      user_role: ''
  } }

  describe "GET #is_logged_in" do

    context "as an admin" do
      it "returns http success" do
        get :login, params: {}, session: admin_session
        expect(response).to redirect_to(calendar_path)
      end
    end

    context "as a user" do
      it "returns http success" do
        get :login, params: {}, session: user_session
        expect(response).to redirect_to(show_dash_path)
      end
    end

    context "while not logged in" do
      it "returns http success" do
        get :login, params: {}, session: logout_session
        expect(response).to be_successful
        expect(response).not_to be_redirect
      end
    end

  end

end
