# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user&.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = 'ログインに成功しました'
      remember(user)
      redirect_back_or(groups_path)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
