# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_task, only: %i[show edit update destroy complete incomplete]

  def new
    @task = Task.new
  end

  def create
    # post_user_idにcurrent_userを、post_group_idにcurrent_groupをnameに好きな値を入れたい
    @task = current_user.tasks.build(task_params)
    @task.status = 'incomplete'
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
    @records = current_task.records.order(id: :desc).page(params[:page]).per(10)
    before_created_at = nil
    @graph_y = []
    @graph_x = []
    current_task.records.each do |record|
      if record.created_at.strftime('%Y/%m/%d') != before_created_at
        @graph_y << record.progress
        @graph_x << record.created_at.strftime('%Y/%m/%d')
      elsif record.created_at.strftime('%Y/%m/%d') == before_created_at
        @graph_y.pop
        @graph_x.pop
        @graph_y << record.progress
        @graph_x << record.created_at.strftime('%Y/%m/%d')
      end
      before_created_at = record.created_at.strftime('%Y/%m/%d')
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクの内容を変更しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの内容を変更できませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    session[:task_id] = nil
    flash[:success] = 'タスクを削除しました'
    redirect_to current_group
  end

  def complete
    @task.status = 'complete'
    @task.save
    flash[:success] = "#{@task.name}を完了にしました"
    redirect_to current_group
  end

  def incomplete
    @task.status = 'incomplete'
    @task.save
    flash[:success] = "#{@task.name}を未完了に戻しました"
    redirect_to current_group
  end
end

private

def task_params
  params.require(:task).permit(:name, :in_charge, :time_limit)
end

def correct_task
  @task = current_group.tasks.find_by(post_group_id: current_group.id, id: params[:id])
  redirect_to groups_url unless @task
end
