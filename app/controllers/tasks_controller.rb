class TasksController < ApplicationController
  def create
  end

  def update
    @task = Task.find_by(id: params[:task][:id]) || Task.new
    if @task.update_attributes task_params
      render json: { id: @task.id }
    else
      render text: 'Task failed to update.'
    end
  end

  def destroy
    Task.find_by(id: params[:task][:id]).try :destroy
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:id, :due, :status, :title, :body)
  end
end
