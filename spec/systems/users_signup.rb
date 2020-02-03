require 'rails_helper'

RSpec.describe 'users_signup', type: :system do

  scenario '無効な登録情報の時、登録できない' do
    get signup_url
    expect{
      post users_path, params: { user: {
                          email: "user@invalid",
                          password: "foo",
                          password_confirmation: "bar"}}
    }.not_to change( User, :count )
    expect(response.body).to include '新規登録'
    expect(response.body).to have_selector 'div#error_explanation'
    expect(response.body).to have_selector 'div.alert'
    expect(response.body).to have_selector 'div.alert-danger'
    expect(response.body).to have_selector 'form[action="/users"]'
  end

  scenario '有効な登録情報の時、登録できる' do
    get signup_url
    expect{
      post users_path, params: { user: {name: "Example User",
                          user_name: "Example User Name",
                          email: "user@example.com",
                          password: "password",
                          password_confirmation: "password"}}
    }.to change( User, :count ).by(1)
    follow_redirect!
    expect(response.body).to include 'グループを作成して<br>タスクをメンバーと共有しましょう!'
    expect(response.body).to have_selector 'div.alert'
    expect(is_logged_in?).to be_truthy
  end
end
