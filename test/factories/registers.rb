# frozen_string_literal: true

FactoryBot.define do
  factory :register do
    paid_at { '2024-03-29 11:42:24' }
    user { nil }
    society { nil }
    amount { 1.5 }
    title { 'MyText' }
    comment { 'MyText' }
    payment_method { 'MyString' }
    is_income { false }
  end
end
