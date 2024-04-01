# frozen_string_literal: true

users = []

# SEED USERS
2.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: 'password')
end

# SEED SOCIETIES
users.each do |user|
  name = Faker::Company.name
  Society.create!(
    name:,
    address: Faker::Address.street_address,
    zip: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.city,
    siret: Faker::Number.number(digits: 13),
    status: 'SASU',
    capital: Faker::Number.between(from: 1, to: 50_000),
    email: "#{name.downcase.gsub(/\s+/, '').gsub(/[^\w.+-]+/, '')}@yopmail.com",
    user_id: user.id
  )

  # SEED CLIENTS
  10.times do
    Client.create!(
      business_name: Faker::Company.name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address: Faker::Address.street_address,
      zip: Faker::Address.unique.postcode.to_i,
      city: Faker::Address.city,
      siret: Faker::Number.unique.number(digits: 13),
      is_pro: Faker::Boolean.boolean,
      user_id: user.id,
      society_id: user.societies.all.sample.id,
      country: Faker::Address.country,
      email: Faker::Internet.email
    )
  end

  # SEED INVOICES
  50.times do |i|
    date = Time.zone.today - rand(0..3).month
    due_date = date + 1.month
    is_draft = [true, false].sample
    is_paid = is_draft ? false : [true, false].sample
    status = if is_draft
               'draft'
             elsif is_paid
               'paid'
             else
               'pending'
             end
    society = user.societies.all.sample
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
      user_id: user.id,
      society_id: society.id,
      client_id: society.clients.all.sample.id,
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

  # SEED REGISTERS
  10.times do
    amount = rand(-10000.00..10000.00)
    Register.create!(
      society_id: user.societies.all.sample.id,
      invoice_id: [user.invoices.all.sample.id, nil].sample,
      title: Faker::Lorem.sentence,
      paid_at: Time.zone.today - rand(0..3).month,
      payment_method: %w[card cash transfer cheque other].sample,
      is_income: amount >= 0,
      amount: amount
    )
  end
end