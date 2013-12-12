class DashboardController < ApplicationController
  def index
    @dashboard = Dashboard.new
  end

  def tasks
    @dashboard = Dashboard.new
    render partial: 'tasks/all', locals: { tasks: @dashboard.tasks }
  end

  private

  def action_allowed?
    current_user
  end
end
