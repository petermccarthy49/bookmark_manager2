require 'bcrypt'

class User

  attr_reader :password
  attr_accessor :password_confirmation

  include DataMapper::Resource
  # when we 'include' and call DataMapper as a class, 
  # Resource is the module in that class
  # include takes all the methods in the Resource module 
  # and makes them class methods inside the User class

  property :id,       Serial
  property :email,    String

  # this stores both p/w and Salt, its Text as String only 
  # holds 50 chars which is not only for Hash and Salt
  property :password_digest, Text

  property :email, String, :unique => true, :message => "This email is already registered"

  # this is DMs method of validating the model which 
  # won't be saved unless both p/w and p/w conf match 
  validates_confirmation_of :password
  # validates_uniqueness_of   :email

  # when assigned the p/D we don't store it directly
  # instead, we generate a password digest, that looks like this:
  # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
  # and save to the db. The digest, provided by bcrypt,
  # has both the p/d Hash and the Salt. We save it to the
  # db instead of the plain p/d for security reasons.
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end