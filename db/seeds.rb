# frozen_string_literal: true

users = []

# SEED USERS
3.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: 'password')
end

# SEED SOCIETIES

societies = []

10.times do
  name = Faker::Company.name
  societies << Society.create!(
    name: name,
    address: Faker::Address.street_address,
    zip: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    siret: Faker::Number.number(digits: 13),
    status: 'SASU',
    capital: Faker::Number.between(from: 1, to: 50_000),
    email: "#{name.downcase.gsub(/\s+/, '').gsub(/[^\w.+-]+/, '')}@yopmail.com",
    user_id: users.sample.id
  )
end

#   # SEED CLIENTS
  clients = []
  10.times do
    clients << Client.create!(
      business_name: Faker::Company.name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address: Faker::Address.street_address,
      zip: Faker::Address.unique.postcode.to_i,
      city: Faker::Address.city,
      siret: Faker::Number.unique.number(digits: 13),
      is_pro: Faker::Boolean.boolean,
      user_id: users.sample.id,
      society_id: societies.sample.id,
      country: Faker::Address.country,
      email: Faker::Internet.email
    )
  end

#   # SEED INVOICES
  50.times do |i|
    date = Time.zone.today - rand(0..3).month
    due_date = date + 1.month
    is_draft = [true, false].sample
    is_paid = !is_draft
    status = is_draft ? 'draft' : 'paid'
    society = societies.sample.id
    number = date.strftime('%Y%m%d') + (i + 1).to_s

    items = []
    rand(1..6).times do |j|
      quantity = rand(1..10)
      price = rand(1..1000)
      taxpercent = [0, 5.5, 10, 20].sample

      items << {
        id: j + 1,
        name: Faker::Commerce.product_name,
        quantity:,
        unit: %w[unit heure jour semaine mois forfait].sample,
        price:,
        description: Faker::Lorem.sentence,
        discount: [{
          name: 'test',
          percentage: 10,
          total: (price * quantity * 0.1).round(2)
        }, nil].sample,
        tax: {
          percentage: taxpercent,
          total: (quantity * price * (taxpercent / 100.0)).round(2)
        }
      }
    end

    contenttax = items.each_with_object({}) do |item, sum|
      sum[item[:tax][:percentage]] ||= 0
      sum[item[:tax][:percentage]] += item[:tax][:total]
    end

    contenttax_array = contenttax.map do |percentage, total|
      { percentage:, total: total.round(2) }
    end

    subtotal = items.reduce(0) { |sum, item| sum + (item[:price] * item[:quantity]) }.round(2)
    tax = items.reduce(0) { |sum, item| sum + item[:tax][:total] }.round(2)
    total = subtotal + tax
    sale = items.reduce(0) do |sum, item|
      if item[:discount] && item[:discount][:total]
        sum + item[:discount][:total]
      else
        sum
      end
    end

    Invoice.create(
      user_id: users.sample.id,
      society_id: societies.sample.id,
      client_id: clients.sample.id,
      title: "Invoice #{number}",
      number:,
      content: { items:, tax: contenttax_array }.to_json,
      issued_at: date,
      due_at: due_date,
      subtotal: subtotal.round(2),
      tva: tax.round(2),
      total: total.round(2),
      status:,
      sale: sale.round(2),
      is_draft:,
      is_paid:,
      category: %w[invoice quotation].sample
    )
  end