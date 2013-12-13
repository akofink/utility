class LinksController < ApplicationController
  def show
    @links = Link.where id: params[:id], user_id: current_user.id
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new link_params
    if @link.save
      flash[:success] = 'Link created'
      redirect_to user_links_path current_user
    else
      redirect_back
    end
  end

  def update
    @link = Link.find params[:id]
    if @link.update_attributes link_params
      flash[:success] = 'Link updated'
      redirect_to user_links_path current_user
    else
      render :edit
    end
  end

  def edit
    @link = Link.find params[:id]
  end

  def destroy
    @link = Link.find params[:id]
    if @link.destroy
      flash[:success] = 'Link destroyed'
      redirect_to user_links_path current_user
    else
      redirect_back
    end
  end

  def index
    @links = Link.order 'LOWER(content)'
    if params[:user_id]
      @links = @links.where user_id: params[:user_id]
    end
  end

  private

  def link_params
    params.require(:link).permit(:content, :url, :user_id)
  end

  def action_allowed?
    return unless current_user
    case params[:action]
    when 'index'
      current_user.id == params[:user_id].to_i
    when 'create', 'update', 'destroy'
      current_user.id == link_params[:user_id].to_i
    when 'destroy', 'edit'
      Link.find(params[:id]).user == current_user
    else
      current_user
    end
  end
end
