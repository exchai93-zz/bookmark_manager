require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :required => true, :format => :email_address, :unique => true
  property :password_digest, Text

  validates_confirmation_of :password
  attr_reader :password

  def password=(password)
    @password = password #so that password is saved
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  attr_accessor :password_confirmation

end
