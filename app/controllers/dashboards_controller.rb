class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.new
  end

  def tasks
    @dashboard = Dashboard.new
    render partial: 'tasks/all', id: -1, locals: { tasks: @dashboard.tasks }
  end

  private

  def action_allowed?
    current_user
  end
end
