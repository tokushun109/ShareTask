# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    # formで:params中の:sessionに送ったuser_nameとpasswordを受け取る
    user_name = params[:session][:user_name]
    password = params[:session][:password]
    # 受け取ったuser_nameとpasswordが存在するか確認
    # loginメソッドで送られたデータを照合する機能をつける
    if login(user_name, password)
      flash[:success] = 'ログインに成功しました'
      redirect_to groups_url
    else
      # renderはアクションを通さずにviewを表示するだけ→nowをつけてアクションを経由するまでflashを表示する
      flash.now[:danger] = 'ログインに失敗しました'
      # sessions/new.html.erbを表示
      render 'new'

    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  private

  def login(user_name, password)
    # user_nameでデータを探す
    @user = User.find_by(user_name: user_name)
    # @userが存在し、かつ@userのpasswordも存在するなら
    if @user&.authenticate(password)
      # ログイン成功時は:sessionの中にuser_idを作成し、データを称号したidを入れておく
      session[:user_id] = @user.id
      # trueを返して、ログイン成功時の操作をcreateアクションに引き継ぐ
      true
    else
      # 称号した結果データがない場合、ログイン失敗となりcreateアクションのログイン失敗時の操作に引き継ぐ
      false
    end
  end
end
