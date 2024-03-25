users = []
invoices = []

# SEED USERS
2.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: "password")
end

# SEED SOCIETIES
users.each do |user|
  name = Faker::Company.name
  Society.create!(
    name: name, 
    adress: Faker::Address.street_address, 
    zip: Faker::Address.zip_code, 
    city: Faker::Address.city, 
    country: Faker::Address.city, 
    siret: Faker::Number.number(digits:13), 
    status: "SASU", 
    capital: Faker::Number.between(from: 1, to: 50000), 
    email: "#{name.downcase.gsub(/\s+/, '').gsub(/[^\w.+-]+/, '')}@yopmail.com", 
    user_id: user.id
  )
end

# SEED CLIENTS
users.each do |user|
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
      society_id: user.societies.all.sample.id
    )
  end
end

# SEED INVOICES
users.each do |user|
  30.times do |i|
    date = Date.today - rand(0..3).month
    due_date = date + 1.month
    is_draft = [true, false].sample
    is_paid = !is_draft
    status = is_draft ? "draft" : "paid"
    society = user.societies.all.sample
    number = date.strftime("%Y%m%d") + (i + 1).to_s

    items = []
    rand(1..6).times do |j|
      quantity = rand(1..10)
      price = rand(1..1000)
      taxpercent = [0, 5.5, 10, 20].sample

      items << {
        id: j + 1,
        name: Faker::Commerce.product_name,
        quantity: quantity,
        unit: ["unit", "heure", "jour", "semaine", "mois", "forfait"].sample,
        price: price,
        description: Faker::Lorem.sentence,
        discount: [{
          name: "test",
          percentage: 10,
          total: (price * quantity * 0.1).round(2)
        }, nil].sample,
        tax: {
          percentage: taxpercent,
          total: (quantity * price * (taxpercent / 100.0)).round(2)
        }
      }
    end

    contenttax = items.reduce({}) do |sum, item|
      sum[item[:tax][:percentage]] ||= 0
      sum[item[:tax][:percentage]] += item[:tax][:total]
      sum
    end

    contenttax_array = contenttax.map do |percentage, total|
      { percentage: percentage, total: total.round(2) }
    end

    subtotal = items.reduce(0){|sum, item| sum + item[:price] * item[:quantity]}.round(2)
    tax = items.reduce(0){|sum, item| sum + item[:tax][:total]}.round(2)
    total = subtotal + tax
    sale = items.reduce(0) do |sum, item|
      if (item[:discount] && item[:discount][:total])
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
      number: number,
      content: {items: items, tax: contenttax_array}.to_json,
      date: date,
      due_date: due_date,
      subtotal: subtotal.round(2),
      tva: tax.round(2),
      total: total.round(2),
      status: status,
      sale: sale.round(2),
      is_draft: is_draft,
      is_paid: is_paid
    )
  end
end