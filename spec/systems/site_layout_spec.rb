require 'rails_helper'

RSpec.describe 'site layout', type: :system do
  context 'root_pathにアクセスした時' do
    before { visit root_path }
    subject { page }
    it '各リンク先が所望の場所につながっていること' do
      is_expected.to have_link 'Share Task', href: root_path
      is_expected.to have_link '新規登録', href: signup_path
      is_expected.to have_link '使い方', href: how_to_use_path
      is_expected.to have_link 'ログイン', href: login_path
      is_expected.to have_link '登録して使ってみる', href: signup_path
      is_expected.to have_link '使い方を確認する≫', href: how_to_use_path
    end
  end
end
