10.times do |i|
  users << User.create(email: "user#{i}@user.fr", password: "password")
end