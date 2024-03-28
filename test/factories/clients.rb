# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    first_name { 'MyString' }
    last_name { 'MyString' }
    address { 'MyText' }
    zip { 1 }
    city { 'MyString' }
    siret { 1 }
    is_pro { false }
    user { nil }
  end
end
