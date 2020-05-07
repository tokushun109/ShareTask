require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  let(:group) { build(:group) }

  context 'テストで使用するuserが有効な値の時' do
    it 'validになること' do
      expect(user).to be_valid
    end
  end

  describe 'nameの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        user.name = ' '
        expect(user).to be_invalid
      end
    end
    context '51文字以上の場合' do
      it 'invalidになること' do
        user.name = 'a' * 51
        expect(user).to be_invalid
      end
    end
  end

  describe 'user_nameの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        user.user_name = ' '
        expect(user).to be_invalid
      end
    end
    context '51文字以上の場合' do
      it 'invalidになること' do
        user.user_name = 'a' * 51
        expect(user).to be_invalid
      end
    end
    context '一意性がない値を入れた時' do
      it 'invalidになること' do
        duplicate_user = user.dup
        duplicate_user.user_name = user.name.upcase
        user.save!
        expect(duplicate_user).to be_invalid
      end
    end
  end

  describe 'emailの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        user.email = ' '
        expect(user).to be_invalid
      end
    end
    context '256文字以上の場合' do
      it 'invalidになること' do
        user.email = 'a' * 244 + '@example.com'
        expect(user).to be_invalid
      end
    end
    context '一意性がない値を入れた時' do
      it 'invalidになること' do
        duplicate_user = user.dup
        duplicate_user.email = user.name.upcase
        user.save!
        expect(duplicate_user).to be_invalid
      end
    end
    context '有効な値を入れた時' do
      it 'validになること' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end
    context '有効ではない値を入れた時' do
      it 'invalidになること' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).to be_invalid
        end
      end
    end
  end

  describe 'passwordの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        user.password = user.password_confirmation = ' ' * 6
        expect(user).to be_invalid
      end
    end
    context '5文字以内の場合' do
      it 'invalidになること' do
        user.password = user.password_confirmation = 'a' * 5
        expect(user).to be_invalid
      end
    end
  end

  # context 'userが削除された時' do
  #   it '関連するgroupも削除されること' do
  #     user.save
  #     group.save
  #     expect{ user.destroy }.to change {Group.count}.by(-1)
  #   end
  # end

  describe '#authenticated?' do
    it '値がnilのときfalseを返すこと' do
      expect(user.authenticated?(:remember, '')).to be_falsey
    end
  end
end
