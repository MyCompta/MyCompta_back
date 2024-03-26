require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    context "when user is authenticated and authorized" do
      it "returns http success and user data with associated societies" do
        user = User.create(email: "user@example.com", password: "password123")
        sign_in user
        
        society = Society.create(name: "company", adress: "main street", zip: 90000, city: "cityville", country: "elpais", siret: 1234567890123, status: "micro", capital: 1000, email: "company@yopmail.com", user: user)

        get :show, params: { id: user.id }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["email"]).to eq(user.email)
        expect(JSON.parse(response.body)["societies"][0]["name"]).to eq(society.name)
      end
    end

    context "when user is not authenticated" do
      it "returns unauthorized error" do
        get :show, params: { id: 1 } # Supposons que l'ID 1 n'existe pas pour simuler une non-authentification
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is authenticated and authorized" do
      it "destroys the user and returns success message" do
        user = User.create(email: "user@example.com", password: "password123")
        sign_in user

        expect {
          delete :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["message"]).to eq("destroy successful")
      end
    end

    context "when user is not authenticated" do
      it "returns unauthorized error" do
        delete :destroy, params: { id: 1 } # Supposons que l'ID 1 n'existe pas pour simuler une non-authentification
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
