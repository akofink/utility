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
    @task = Task.find_by(id: params[:task][:id])

    if @task.destroy
      render nothing: true
    end
  end

  private

  def task_params
    params.require(:task).permit(:id, :user_id, :due, :status, :title, :body)
  end

  def action_allowed?
    case params[:action]
    when 'create', 'update', 'destroy'
      current_user.id == task_params[:user_id].to_i
    end
  end
end
