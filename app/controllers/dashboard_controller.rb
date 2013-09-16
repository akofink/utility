class DashboardController < ApplicationController
  def show
    @dashboard = Dashboard.new
  end

  def tasks
    @dashboard = Dashboard.new
    render partial: 'tasks/all', locals: { tasks: @dashboard.tasks }
  end

  def email
  end

  def calendar
  end
end
