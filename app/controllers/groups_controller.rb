class GroupsController < ApplicationController
  def index
    @relationships = current_user.relationships.where(status: 'accept')
    @accept_groups = []
    @relationships.each do |relationship|
    @accept_groups.push(Group.find(relationship.group_id))
    end
  end
  
  def new
    @group = Group.new
  end

  def create
    # group_paramsをストロングパラメータで定義する必要あり
    @group = current_user.leader_groups.build(group_params)
    # @group = Group.new(group_params)
    
    if @group.save
      @relation = current_user.relationships.create(group_id: @group.id, status: 'accept')
      flash[:success] = '新しいグループを作成しました'
      # 後ほどgroups_urlに飛ばせるようにする
      redirect_to @group
    
    else
      flash.now[:danger] = 'グループを作成出来ませんでした'
      render :new
    end
  end
  
  def show
    session[:group_id] = params[:id]
    @relationships = current_group.relationships.where(status: 'accept')
    @accept_users_name = []
    @relationships.each do |relationship|
    @accept_users_name.push(User.find(relationship.user_id).name)
    end
  end
  
end
  private
  
def group_params
  params.require(:group).permit(:name)
end