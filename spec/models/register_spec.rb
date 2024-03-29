# spec/models/register_spec.rb
require 'rails_helper'

RSpec.describe Register, type: :model do
  # Set up a valid society to associate with registers
  let(:user) { create(:user) }
  let(:society) { create(:society, user:) }

  # Set up a valid register to test validations
  let(:register) do
    described_class.new(
      society: society,
      title: 'Sample Register',
      payment_method: 'cash',
      paid_at: Time.now,
      amount: 100,
      is_income: true
    )
  end

  describe 'associations' do
    it { should belong_to(:society) }
    it { should belong_to(:invoice).optional }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(register).to be_valid
    end

    it { should validate_presence_of(:society) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(255) }
    it { should validate_presence_of(:payment_method) }
    it { should validate_presence_of(:paid_at) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:is_income) }
  end
end