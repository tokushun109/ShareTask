class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :show, :search, :edit_pw]
  before_action :set_user, only: [:edit,:edit_pw, :update, :edit_pw]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
       redirect_to login_url
      
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
    
  end

  def edit
  end
  
  def edit_pw
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を変更しました'
       redirect_to groups_url
       
    else
      flash.now[:danger] = 'ユーザー情報を変更できませんでした'
       render :edit
    end
  end
  
  def search
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page]).per(10)
  end
  
  def group_users
    @relationships = current_group.relationships.where(status: 'accept')
    @group_users = []
    @relationships.each do |relationship|
      @group_users.push(User.find(relationship.user_id))
    end
    @group_users = Kaminari.paginate_array(@group_users).page(params[:page]).per(10)
  end
  
  def expulsion
    @relationship = current_group.relationships.find_by(user_id: params[:id])
    @relationship.destroy
    flash[:success] = "ユーザーを退去しました"
    redirect_to current_group
    
  end
  
end

private

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = current_user
  end