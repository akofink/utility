class LinksController < ApplicationController
  def show
    @links = Link.where id: params[:id]
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new links_params
    if link.save
      flash[:success] = 'Link created'
      redirect_to link
    else
      flash[:error] = "Unsuccessful:
      #{link.errors.full_messages.join('<br>')}"
      redirect_back
    end
  end

  def update
  end

  def edit
    @link = Link.find params[:id]
  end

  def destroy
    link = Link.find params[:id]
    if link.destroy
      flash[:success] = 'Link destroyed'
      redirect_to Link
    else
      flash[:error] = "Unsuccessful:
      #{link.errors.full_messages.join('<br>')}"
      redirect_back
    end
  end

  def index
    @links = Link.order :updated_at
  end

  private

  def links_params
    params.require(:link).permit(:content, :url)
  end
end
