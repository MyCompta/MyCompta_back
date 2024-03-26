require 'rails_helper'

RSpec.describe Invoice, type: :model do

  before(:each) do
    @user = User.create(email: "user@yopmail.com", password: "123456")
    @society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: @user.id)
    @client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: "1234567890147", is_pro: "true", user_id: @user.id, society_id: @society.id, business_name: "client business")
  end

  
  context "association" do
    describe "invoice" do
      it { should belong_to(:user) }
      it { should belong_to(:society) }
      it { should belong_to(:client) }
    end
  end

end