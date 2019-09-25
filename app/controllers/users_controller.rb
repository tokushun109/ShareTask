class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
       redirect_to groups_url
      
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
    
  end

  def edit
  end

  def update
  end
  
  def search
    @search = User.ransack(params[:q])
    @users = @search.result
  end
  
end

private

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end