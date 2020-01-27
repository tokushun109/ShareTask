# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_record, only: %i[edit update destroy]

  def new
    @record = Record.new
  end

  def create
    @record = current_task.records.build(record_params)
    if @record.save
      flash[:success] = '新しい進捗を追加しました'
      redirect_to current_task

    else
      flash.now[:danger] = '進捗を追加できませんでした'
      render :new
    end
  end

  def edit; end

  def update
    if @record.update(record_params)
      flash[:success] = '進捗を変更しました'
      redirect_to current_task
    else
      flash.now[:danger] = '進捗を変更できませんでした'
      render :edit
    end
  end

  def destroy
    @record.destroy
    flash[:success] = '進捗を削除しました'
    redirect_to current_task
  end
end

private

def record_params
  params.require(:record).permit(:progress, :supplement)
end

def correct_record
  @record = current_task.records.find_by(id: params[:id])
  redirect_to groups_url unless @record
end
