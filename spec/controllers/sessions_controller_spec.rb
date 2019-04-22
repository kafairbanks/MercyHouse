require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "DELETE #destroy" do
    context 'logout' do
      it 'returns to the login page' do
        user_params = {
            provider: "facebook",
            uid: 2199416776802224,
            role: ""}

        user = User.create! user_params
        valid_session = {
            user_id: user.id,
            user_name: user.name,
            user_role: user.role
        }
        expect(delete :destroy, params: {}, session: valid_session).to redirect_to(login_path)

      end
    end
  end

end
