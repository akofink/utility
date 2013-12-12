module AuthorizationHelper
  def authorize
    unless action_allowed?
      flash[:warning] = "#{params[:controller]}##{params[:action]} Denied"
      redirect_back
    end
  end

  def action_allowed?
    current_user && current_user.admin?
  end
end
