class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new users_sessions_params

    if @user_session.save
      self.current_user = @user_session.user
      flash[:success] = 'Logged In'
      redirect_to '/'
    else
      render :new
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

  def action_allowed?
    case params[:action]
    when 'new'
      redirect_to dashboard_path(current_user.id) if current_user
      true
    else
      true
    end
  end
end
