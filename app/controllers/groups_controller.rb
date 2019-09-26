class GroupsController < ApplicationController
  def index
  end

  def new
    @group = Group.new
  end

  def create
    # group_paramsをストロングパラメータで定義する必要あり
    @group = current_user.leader_groups.build(group_params)
    # @group = Group.new(group_params)
    
    if @group.save
      flash[:success] = '新しいグループを作成しました'
      # 後ほどgroups_urlに飛ばせるようにする
      redirect_to search_users_url
    
    else
      flash.now[:danger] = 'グループを作成出来ませんでした'
      render :new
    end  
  end
end
  private
  
  def group_params
    params.require(:group).permit(:name)
  end