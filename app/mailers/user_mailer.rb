class UserMailer < Devise::Mailer
 default from: "youremail@test.com"

 def reset_password_instructions(record, token, opts={})
  @front_url = "http://localhost:5173"
   super
 end

end
