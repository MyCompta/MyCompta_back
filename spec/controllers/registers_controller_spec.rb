require 'rails_helper'

RSpec.describe RegistersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:society) { create(:society, user: user) }
  let(:valid_attributes) { { paid_at: Time.zone.now, society_id: society.id, amount: 100, title: 'Payment', comment: 'Monthly fee', payment_method: 'cash', is_income: true } }
  let(:invalid_attributes) { { paid_at: nil, society_id: nil, amount: nil, title: nil, comment: nil, payment_method: nil, is_income: nil } }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      register = Register.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
      expect(assigns(:registers)).to include(register)
    end

    context 'when filtering by society_id' do
      it 'returns registers for the specified society' do
        other_society = create(:society, user: user)
        Register.create! valid_attributes
        Register.create! valid_attributes.merge(society: other_society)

        get :index, params: { society_id: society.id }
        expect(response).to be_successful
        expect(assigns(:registers)).to all(satisfy {|r| r.society_id == society.id})
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      register = Register.create! valid_attributes
      get :show, params: { id: register.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Register" do
        expect {
          post :create, params: { register: valid_attributes }
        }.to change(Register, :count).by(1)
      end

      it "renders a JSON response with the new register" do
        post :create, params: { register: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new register" do
        post :create, params: { register: invalid_attributes.merge(society_id: society.id) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context "with no society_id" do
      it "renders a JSON response with errors for the new register" do
        post :create, params: { register: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  # Add tests for PATCH/PUT #update and DELETE #destroy as needed.
end