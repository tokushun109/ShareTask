require 'rails_helper'

RSpec.describe Record, type: :model do
  subject(:record) { build(:record) }

  context 'テストで使用するrecordが有効な値の時' do
    it 'validになること' do
      expect(record).to be_valid
    end
  end

  describe 'supplementの有効性' do
    context '501文字以上の場合' do
      it 'invalidになること' do
        record.supplement = 'a' * 501
        expect(record).to be_invalid
      end
    end
  end

  describe 'progressの有効性' do
    context '空白の場合' do
      it 'invalidになること' do
        record.progress = ' '
        expect(record).to be_invalid
      end
    end
    context '0未満の場合' do
      it 'invalidになること' do
        record.progress = -1
        expect(record).to be_invalid
      end
    end
    context '100より大きい場合' do
      it 'invalidになること' do
        record.progress = 101
        expect(record).to be_invalid
      end
    end
  end
end
