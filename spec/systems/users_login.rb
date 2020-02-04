require 'rails_helper'

RSpec.describe 'users_login', type: :system do

  let(:user) { create(:user) }

  scenario '無効な情報の時、ログインできない' do
    get login_url
    expect(response.body). to include 'ログイン'
    post login_path,params:{session: {email:"",password:""}}
    expect(response.body). to include 'ログイン'
    expect(flash.empty?).to be_falsey
    get root_path
    expect(flash.empty?).to be_truthy

  end
  scenario '有効な情報でログインし、その後ログアウトする' do
    get login_url
    post login_path,params: {session: {user_name: user.user_name,
                        password: 'foobar'}}
    expect(response).to redirect_to groups_path
    follow_redirect!
    expect(is_logged_in?).to be_truthy
    expect(response.body).to have_link 'ログアウト', href: logout_path
    delete logout_path
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_path
    # 二つ目のウィンドウでログアウトした時
    delete logout_path
    follow_redirect!
    expect(response.body).to have_link 'ログイン', href: login_path
  end

  
end
