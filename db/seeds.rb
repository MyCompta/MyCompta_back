users = []
invoices = []

10.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: "password")
end


100.times do |i|
  date = Date.today - rand(0..3).month
  due_date = date + 1.month
  subtotal = [2500, 4500, 10000, 1400, 16000, 3000, 7600].sample
  tva = 10
  total = subtotal * (1 + tva / 100.0)
  sale = 1
  is_draft = [true, false].sample
  is_paid = [true, false].sample

  Invoice.create(
    user_id: 1,
    title: "Invoice #{i}",
    content: { test: "test" }.to_json,
    date: date,
    due_date: due_date,
    subtotal: subtotal,
    tva: tva,
    total: total,
    sale: sale,
    is_draft: is_draft,
    is_paid: is_paid
  )
end
