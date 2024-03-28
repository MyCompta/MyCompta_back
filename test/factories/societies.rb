# frozen_string_literal: true

FactoryBot.define do
  factory :society do
    name { 'MyString' }
    address { 'MyString' }
    zip { 1 }
    city { 'MyString' }
    country { 'MyString' }
    siret { 1 }
    status { 'MyString' }
    capital { 1 }
    email { 'MyString' }
  end
end
