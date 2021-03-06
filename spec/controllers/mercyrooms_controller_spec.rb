require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe MercyroomsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Mercyroom. As you add validations to Mercyroom, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      mercyhomes_id: 1,
      RoomName: 'King Suite',
      RoomDesc: 'Fit for a Jeff',
      firstfloor: false
    }
  }

  let(:invalid_attributes) {
    {
        mercyhomes_id: nil,
        RoomName: 'King Suite',
        RoomDesc: 'Fit for a Jeff',
        firstfloor: false
    }
  }

  let(:invalid_attributes2) {
    {
        mercyhomes_id: '10',
        RoomName: 'King Suite',
        RoomDesc: 'Fit for a Jeff',
        firstfloor: false
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MercyroomsController. Be sure to keep this updated too.
  let(:valid_session) { {
      user_id: 1,
      user_role: 'admin'
  } }
  describe "GET #index" do
    context "without params" do
      it "returns a success response" do
        mercyroom = Mercyroom.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    context "with params" do
      it "returns a success response" do
        mercyroom = Mercyroom.create! valid_attributes
        get :index, params: {name: Mercyhome.last.HouseName}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      mercyroom = Mercyroom.create! valid_attributes
      get :show, params: {id: mercyroom.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      mercyroom = Mercyroom.create! valid_attributes
      get :edit, params: {id: mercyroom.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Mercyroom" do
        expect {
          post :create, params: {mercyroom: valid_attributes}, session: valid_session
        }.to change(Mercyroom, :count).by(1)
      end

      it "redirects to the created mercyroom" do
        post :create, params: {mercyroom: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Mercyroom.last)
      end
    end

    context "with invalid params" do
      it "redirects to the new template" do
        post :create, params: {mercyroom: invalid_attributes}, session: valid_session
        expect(response).to render_template(:new)
      end
    end

    context "with nonexistent home" do
      it "redirects to the new template" do
        post :create, params: {mercyroom: invalid_attributes2}, session: valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
            mercyhomes_id: '1',
            RoomName: 'King Suite',
            RoomDesc: 'Fit for a King',
            firstfloor: false
        }
      }

      it "updates the requested mercyroom" do
        mercyroom = Mercyroom.create! valid_attributes
        put :update, params: {id: mercyroom.to_param, mercyroom: new_attributes}, session: valid_session
        mercyroom.reload
        expect(controller.notice).to eql('Mercyroom was successfully updated.')
      end

      it "redirects to the mercyroom" do
        mercyroom = Mercyroom.create! valid_attributes
        put :update, params: {id: mercyroom.to_param, mercyroom: valid_attributes}, session: valid_session
        expect(response).to redirect_to(mercyroom)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        mercyroom = Mercyroom.create! valid_attributes
        put :update, params: {id: mercyroom.to_param, mercyroom: invalid_attributes}, session: valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested mercyroom" do
      mercyroom = Mercyroom.create! valid_attributes
      expect {
        delete :destroy, params: {id: mercyroom.to_param}, session: valid_session
      }.to change(Mercyroom, :count).by(-1)
    end

    it "redirects to the mercyrooms list" do
      mercyroom = Mercyroom.create! valid_attributes
      delete :destroy, params: {id: mercyroom.to_param}, session: valid_session
      expect(response).to redirect_to(mercyrooms_url)
    end
  end

end
