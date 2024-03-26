require 'rails_helper'


RSpec.describe SocietiesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    it "returns http success" do
      user = User.create(email: "user@example.com", password: "password123")
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success for authorized user" do
      user = User.create(email: "user@example.com", password: "password123")
      sign_in user
      society = Society.create(name: "company", adress: "main street", zip: 90000, city: "cityville", country: "elpais", siret: 1234567890123, status: "micro", capital: 1000, email: "company@yopmail.com", user: user)
      get :show, params: { id: society.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new society" do
      user = User.create(email: "user@example.com", password: "password123")
      sign_in user
      expect {
        post :create, params: { society: { name: "company", adress: "main street", zip: 90000, city: "cityville", country: "elpais", siret: 1234567890123, status: "micro", capital: 1000, email: "company@yopmail.com", user_id: user.id } }
      }.to change(Society, :count).by(1)
    end
  end

  describe "PATCH #update" do
    it "updates society attributes for authorized user" do
      user = User.create(email: "user@example.com", password: "password123")
      sign_in user
      society = Society.create(name: "company", adress: "main street", zip: 90000, city: "cityville", country: "elpais", siret: 1234567890123, status: "micro", capital: 1000, email: "company@yopmail.com", user: user)
      new_name = "New Society Name"
      patch :update, params: { id: society.id, society: { name: new_name } }
      society.reload
      expect(society.name).to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the society for authorized user" do
      user = User.create(email: "user@example.com", password: "password123")
      sign_in user
      society = Society.create(name: "company", adress: "main street", zip: 90000, city: "cityville", country: "elpais", siret: 1234567890123, status: "micro", capital: 1000, email: "company@yopmail.com", user: user)
      expect {
        delete :destroy, params: { id: society.id }
      }.to change(Society, :count).by(-1)
    end
  end
end
