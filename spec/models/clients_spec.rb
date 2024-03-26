require 'rails_helper'

RSpec.describe Client, type: :model do

  before(:each) do
    @user = User.create(email: "user@yopmail.com", password: "123456")
    @society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: @user.id)
    @client = Client.create(first_name: "Martin", last_name: "joe", address: "client adress", zip:"12345", city: "client city", siret: 123, is_pro: "true", user_id: @user.id, society_id: @society.id, business_name: "client business")
  end

  context "association" do
    describe "client" do
      it { should belong_to(:user) }
      it { should belong_to(:society) }
      it { should have_many(:invoices) }
    end
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@client).to be_a(Client)
      expect(@client).to be_valid
    end

    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:society_id) }

    it "validates numericality of zip" do
      should validate_numericality_of(:zip).only_integer
    end

    it "validates inclusion of is_pro" do
      should allow_value(true, false).for(:is_pro)
    end

    # it "validates presence of siret" do
    #   should validate_presence_of(:siret)
    # end
  end


  context "public instance methods" do
    describe "zip" do
      it "should be an integer" do
        expect(@client.zip).to be_an(Integer)
      end
    end
  end


    describe "siret" do
      it "should allow nil or integer" do
        expect(@client.siret).to be_nil.or be_an(Integer)
      end
    end


    describe "is_pro" do
      it "should include true or false" do
        expect(@client.is_pro).to satisfy { |value| [true, false].include?(value) }
      end
    end

end