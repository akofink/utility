class UsersController < ApplicationController
  def index
    @users = User.order :updated_at
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new params[:user]
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new users_params
    if @user.save
      flash[:success] = 'User account created'
      self.current_user = @user
      redirect_to @user
    else
      render :edit
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      flash[:success] = 'User account updated'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find params[:id]
    if user.destroy
      flash[:success] = 'User account destroyed'
      redirect_to User
    else
      redirect_back
    end
  end

  private

  def users_params
    params.require(:user).
      permit(:login, :password, :password_confirmation)
  end

  def action_allowed?
    case params[:action]
    when 'new', 'create', 'edit', 'update'
      true
    else
      current_user
    end
  end
end
