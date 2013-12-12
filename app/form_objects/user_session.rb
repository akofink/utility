class UserSession
  include ActiveRecord::Validations

  attr_accessor :login, :password, :user, :errors

  def initialize(args = {})
    @user = User.find_by login: args[:login]
    @valid = @user.password == args[:password] if @user
  end

  def save
    unless @valid
      @errors ||= UserSessionErrors.new(self)
      @errors.add :password, 'is invalid.'
    end

    @valid
  end
end

class UserSessionErrors < ActiveModel::Errors
end
