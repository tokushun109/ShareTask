require 'rails_helper'



RSpec.describe 'groups_index', type: :system do

  let(:user) { create(:user) }

  scenario 'グループ一覧のページネーションテスト' do
    log_in_as(user, 'foobar')
    get groups_url
    expect(response.body). to include 'グループ一覧'
    expect(response.body).to have_selector 'div.pagination'
  end
end
