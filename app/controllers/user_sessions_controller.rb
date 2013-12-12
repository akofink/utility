class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    user_session = UserSession.new users_sessions_params

    if user_session.save
      self.current_user = user_session.user
      flash[:success] = 'Logged In'
      redirect_to '/'
    else
      flash[:error] = "Could not log in: #{user_session.errors.full_messages.join('<br>')}"
      redirect_back
    end
  end

  def destroy
    flash[:info] = 'Logged Out'
    self.current_user = nil
    redirect_to '/'
  end

  private

  def users_sessions_params
    params.require(:user_session).
      permit(:login, :password, :password_confirmation)
  end
end
