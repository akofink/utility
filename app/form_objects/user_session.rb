class UserSession
  include ActiveRecord::Validations

  attr_accessor :login, :password, :user, :errors

  def initialize(args = {})
    @user = User.find_by login: args[:login]
    @errors ||= UserSessionErrors.new(self)
    @valid = @user.password == args[:password] if @user
  end

  def save
    unless @valid
      @errors.add :password, 'is invalid.'
    end

    @valid
  end

  def error_header
    "prevented login:"
  end
end

class UserSessionErrors < ActiveModel::Errors
end
