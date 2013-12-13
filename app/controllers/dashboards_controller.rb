class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.find(current_user.id)
  end

  def tasks
    @dashboard = Dashboard.find(current_user.id)
    render partial: 'tasks/all',
      id: -1,
      locals: {
        tasks: @dashboard.tasks
      }
  end

  private

  def action_allowed?
    case params[:action]
    when 'tasks'
      true
    else
      current_user.id == params[:id].to_i
    end
  end
end
