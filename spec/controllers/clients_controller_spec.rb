require 'rails_helper'


RSpec.describe ClientsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    context "when user is authenticated and authorized" do
      it "returns http success and client data with associated invoices when society_id is provided" do
        user = User.create(email: "user@yopmail.com", password: "123456")
        sign_in user
        
        society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

        client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: 123, is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

        get :index, params: { society_id: society.id }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)[0]["first_name"]).to eq(client.first_name)
      end
    end

    context "when user is not authenticated" do
      it "returns unauthorized error" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    it "returns http success and client data with associated invoices" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: 123, is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

      get :show, params: { id: client.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["first_name"]).to eq(client.first_name)
    end
  end

  describe "POST #create" do
    it "creates a new client" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      expect {
        post :create, params: { client: { first_name: "John", last_name: "Doe", address: "client address", zip: "54321", city: "client city", siret: 456, is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business" } }
      }.to change(Client, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH #update" do
    it "updates the client" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: 123, is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

      patch :update, params: { id: client.id, client: { first_name: "Updated Name" } }

      expect(response).to have_http_status(:success)
      expect(Client.find(client.id).first_name).to eq("Updated Name")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the client" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: 123, is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

      expect {
        delete :destroy, params: { id: client.id }
      }.to change(Client, :count).by(-1)

      expect(response).to have_http_status(:success)
    end
  end
end
