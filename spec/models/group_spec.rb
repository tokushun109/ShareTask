require 'rails_helper'

RSpec.describe Group, type: :model do

  before do
  	@group = build(:group)
  end

  context "テストで使用するgroupが有効な値の時" do
    it "validになること" do
      expect(@group).to be_valid
    end
  end

  describe "nameの有効性" do
    context "空白の場合" do
      it "invalidになること" do
        @group.name = "  "
        expect(@group).to be_invalid
      end
    end
    context "51文字以上の場合" do
      it "invalidになること" do
        @group.name = "a" * 51
        expect(@group).to be_invalid
      end
    end
  end
end
