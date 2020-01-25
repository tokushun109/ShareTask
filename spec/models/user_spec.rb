require 'rails_helper'

RSpec.describe User, type: :model do
# 書きたいテスト
  before do
  	@user = build(:user)
  end

  context "when user is valid" do
    it "値が入っている場合" do
      expect(@user).to be_valid
    end
  end
# まずはファクトリーでuserをsetする
# （name.email,password,password_confirmation）
end
