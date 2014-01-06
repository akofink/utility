require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :tasks
  has_many :links

  validates_uniqueness_of :login
  validates_presence_of :login
  validates :login, length: { minimum: 6 }
  validates_confirmation_of :password
  validates_presence_of :password

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def admin?
    access_level && access_level > 10
  end
end
