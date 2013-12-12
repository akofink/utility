class UsersController < ApplicationController
  def index
    @users = User.order :updated_at
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    user = User.new users_params
    if user.save
      flash[:success] = 'User account created'
      redirect_to user
    else
      flash[:error] = "Unsuccessful: #{user.errors.full_messages.join('<br>')}"
      redirect_to edit_user_path(user)
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(users_params)
      flash[:success] = 'User account updated'
      redirect_to user
    else
      flash[:error] = "Unsuccessful: #{user.errors.full_messages.join('<br>')}"
      redirect_to edit_user_path(user)
    end
  end

  def destroy
    user = User.find params[:id]
    if user.destroy
      flash[:success] = 'User account destroyed'
      redirect_to User
    else
      flash[:error] = "Unsuccessful: #{user.errors.full_messages.join('<br>')}"
      redirect_back
    end
  end

  private

  def users_params
    params.require(:user).
      permit(:login, :password, :password_confirmation)
  end
end
