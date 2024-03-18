users = []
invoices = []


10.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: "password")
end

10.times do
  name = Faker::Commerce.brand
  Society.create(name: name, adress: Faker::Address.street_address, zip: Faker::Address.zip_code, city: Faker::Address.city, country: Faker::Address.city, siret: Faker::Number.number(digits:14), status: "SASU", capital: Faker::Number.between(from: 1000, to: 50000), email: "#{name.downcase.gsub(/\s+/, '')}@yopmail.com", user_id: 1)
end

10.times do |i|
invoices << Invoice.create(user_id: 1, title: "Invoice #{i}", content: { test: "test" }.to_json, date: Date.today, due_date: Date.today + 1.month , subtotal: 100, tva: 10, total: 110, sale: 1, is_draft: false, is_paid: false)
end

