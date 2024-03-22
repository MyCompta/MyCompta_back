FactoryBot.define do
  factory :invoice do
    user { nil }
    content { "" }
    date { "2024-03-18 11:42:46" }
    due_date { "2024-03-18 11:42:46" }
    title { "MyString" }
    subtotal { 1 }
    tva { 1 }
    total { 1 }
    sale { 1 }
    is_draft { false }
    is_paid { false }
    status { "MyText" }
  end
end
