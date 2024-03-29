# frozen_string_literal: true

FactoryBot.define do
  factory :society do
    name { 'company' }
    address { 'main street' }
    zip { 90_000 }
    city { 'cityville' }
    country { 'elpais' }
    siret { rand(1_000_000_000..9_999_999_999) }
    status { 'micro' }
    capital { 1000 }
    email { 'company@yopmail.com' }
    
    transient do
      user { nil }
    end
    
    after(:build) do |society, evaluator|
      society.user = evaluator.user || create(:user)
    end
  end
end