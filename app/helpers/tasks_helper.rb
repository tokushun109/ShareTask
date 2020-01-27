# frozen_string_literal: true

module TasksHelper
  def current_task
    @current_task ||= Task.find_by(id: session[:task_id])
  end
end
