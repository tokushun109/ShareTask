require 'rails_helper'

RSpec.describe 'groups_index', type: :system do

  before do
    @user = create(:user)
    20.times do
      group = @user.leader_groups.create(name: "example")
      @user.relationships.create(group_id: group.id, status: 'accept')
    end
  end

  scenario 'グループ一覧のページネーションテスト' do
    log_in_as(@user, 'foobar')
    get groups_url
    expect(response.body). to include 'グループ一覧'
    expect(response.body).to have_selector 'ul.pagination'
  end
end
