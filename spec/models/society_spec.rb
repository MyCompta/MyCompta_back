require 'rails_helper'

RSpec.describe Society, type: :model do

  before(:each) do
    @user = User.create(email: "user@yopmail.com", password: "123456")
    @society = Society.create(name: "company", adress: "main street", zip: "90000", city: "cityville", country: "elpais", siret:"1234567890123", status: "micro", capital:"1000", email:"company@yopmail.com", user_id: @user.id)
  end
  
  context "associations" do
    describe "society" do
      it { should belong_to(:user) }
      it { should have_many(:invoices) }
      it { should have_many(:clients) }
    end
  end



  context "validation" do
    it "is valid with valid attributes" do
      expect(@society).to be_a(Society)
      expect(@society).to be_valid
    end

    it{ should validate_presence_of(:name) }
    it{ should validate_presence_of(:adress) }
    it{ should validate_presence_of(:zip) }
    it{ should validate_presence_of(:city) }
    it{ should validate_presence_of(:country) }
    it{ should validate_presence_of(:siret) }
    it{ should validate_presence_of(:status) }
    it{ should validate_presence_of(:capital) }
    it{ should validate_presence_of(:email) }
    it{ should validate_presence_of(:user_id) }
  end




  context "public instance methods" do
    describe "siret" do
      it "should be an integer" do
        expect(@society.siret).to be_an(Integer)
      end

      it "should be unique" do
        expect(@society).to validate_uniqueness_of(:siret)
      end
    end


    describe "capital" do
      it "should be an integer" do
        expect(@society.capital).to be_an(Integer)
      end

      it "should be greater_than_or_equal_to 1" do
        expect(@society.capital).to be >= 1
      end
    end
  end


end