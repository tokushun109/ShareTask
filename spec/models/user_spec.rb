require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  context 'テストで使用するuserが有効な値の時' do
    it 'validになること' do
      expect(@user).to be_valid
    end
  end

  describe 'nameの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        @user.name = ' '
        expect(@user).to be_invalid
      end
    end
    context '51文字以上の場合' do
      it 'invalidになること' do
        @user.name = 'a' * 51
        expect(@user).to be_invalid
      end
    end
  end

  describe 'user_nameの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        @user.user_name = ' '
        expect(@user).to be_invalid
      end
    end
    context '51文字以上の場合' do
      it 'invalidになること' do
        @user.user_name = 'a' * 51
        expect(@user).to be_invalid
      end
    end
    context '一意性がない値を入れた時' do
      it 'invalidになること' do
        duplicate_user = @user.dup
        duplicate_user.user_name = @user.name.upcase
        @user.save!
        expect(duplicate_user).to be_invalid
      end
    end
  end

  describe 'emailの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        @user.email = ' '
        expect(@user).to be_invalid
      end
    end
    context '256文字以上の場合' do
      it 'invalidになること' do
        @user.email = 'a' * 244 + '@example.com'
        expect(@user).to be_invalid
      end
    end
    context '一意性がない値を入れた時' do
      it 'invalidになること' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.name.upcase
        @user.save!
        expect(duplicate_user).to be_invalid
      end
    end
    context '有効ではない値を入れた時' do
      it 'invalidになること' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |_valid_address|
          @user.email = valid_addresses
          expect(@user).to be_invalid
        end
      end
    end
  end

  describe 'passwordの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        @user.password = @user.password_confirmation = ' ' * 6
        expect(@user).to be_invalid
      end
    end
    context '5文字以内の場合' do
      it 'invalidになること' do
        @user.password = @user.password_confirmation = 'a' * 5
        expect(@user).to be_invalid
      end
    end
  end
end
