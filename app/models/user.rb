require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password_digest, Text

  attr_reader :password

  def password=(password)
    @password = password #so that password is saved
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password

  attr_accessor :password_confirmation

end
