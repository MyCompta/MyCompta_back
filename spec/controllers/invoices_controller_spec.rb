require 'rails_helper'


RSpec.describe InvoicesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #index" do
    context "when user is authenticated and authorized" do
      it "returns http success and invoices data when society_id is provided" do
        user = User.create(email: "user@yopmail.com", password: "123456")
        sign_in user
        
        society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

        invoice = Invoice.create(content: "Invoice content", date: Date.today, due_date: Date.tomorrow, title: "Invoice Title", subtotal: 100, tva: 20, total: 120, sale: true, is_draft: false, is_paid: false, status: "pending", number: "INV001", additional_info: "Additional information", user_id: user.id, society_id: society.id)

        get :index, params: { society_id: society.id }

        expect(response).to have_http_status(:success)
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
    it "returns http success and invoice data with author and client info" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: "1234567890147", is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

      invoice = Invoice.create(content: "Invoice content", date: Date.today, due_date: Date.tomorrow, title: "Invoice Title", subtotal: 100, tva: 20, total: 120, sale: true, is_draft: false, is_paid: false, status: "pending", number: "INV001", additional_info: "Additional information", user_id: user.id, society_id: society.id, client_id: client.id)

      get :show, params: { id: invoice.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["invoice"]["content"]).to eq(invoice.content)
      expect(JSON.parse(response.body)["author"]["name"]).to eq(society.name)
      expect(JSON.parse(response.body)["client"]["first_name"]).to eq(client.first_name)
    end
  end

  describe "POST #create" do
    it "creates a new invoice" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: "1234567890147", is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")


    end
  end

  describe "PATCH #update" do
    it "updates the invoice" do
      user = User.create(email: "user@yopmail.com", password: "123456")
      sign_in user
      
      society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: user.id)

      client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: "1234567890147", is_pro: true, user_id: user.id, society_id: society.id, business_name: "client business")

      invoice = Invoice.create(content: "Invoice content", date: Date.today, due_date: Date.tomorrow, title: "Invoice Title", subtotal: 100, tva: 20, total: 120, sale: true, is_draft: false, is_paid: false, status: "pending", number: "INV001", additional_info: "Additional information", user_id: user.id, society_id: society.id, client_id: client.id)

      patch :update, params: { id: invoice.id, invoice: { content: "Updated Content" } }

      expect(response).to have_http_status(:success)
      expect(Invoice.find(invoice.id).content).to eq("Updated Content")
    end
  end

end