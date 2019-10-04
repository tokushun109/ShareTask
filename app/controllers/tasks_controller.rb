class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_task, only: [:destroy]
  
  def new
    @task = Task.new
  end

  def create
    # post_user_idにcurrent_userを、post_group_idにcurrent_groupをnameに好きな値を入れたい
    @task = current_user.tasks.build(task_params)
    @task.post_group_id = current_group.id
    
    if @task.save
      flash[:success] = '新しいタスクを作成しました'
      # 後ほどgroups_urlに飛ばせるようにする
      redirect_to current_group
    
    else
      flash.now[:danger] = 'タスクを作成出来ませんでした'
      render :new
    end
  end

  def show
    session[:task_id] = params[:id]
    @task = current_task
    @records = current_task.records.order(id: :desc)
  end

  def destroy
    @task.destroy
    session[:task_id] = nil
    flash[:success] = 'タスクを削除しました'
    redirect_to current_group
  end
end

  private

def task_params
  params.require(:task).permit(:name, :in_charge, :time_limit)
end

def correct_task
  @task = current_user.tasks.find_by(post_group_id: current_group.id, id: params[:id])
  unless @task
    redirect_to root_url
  end
end