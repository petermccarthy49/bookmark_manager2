
def send_email(user, token)
  RestClient.post "https://api:key-59420320c9fd6451dcef1331691e6a4a"\
  "@api.mailgun.net/v2/sandbox6c2f98958b174e15aa6ff6688f7e0cb0.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandbox6c2f98958b174e15aa6ff6688f7e0cb0.mailgun.org>",
  :to => user.email,
  :subject => "Bookmark Manager2 password reset",
  :text => "Click on this link to reset your password. http://localhost:9292/users/reset_password/:#{token}"
end

