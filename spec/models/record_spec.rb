require 'rails_helper'

RSpec.describe Record, type: :model do

  before do
    @user = create(:user)
    @group = @user.leader_groups.build(name: "Example Group")
    @group.save
    @task = @user.tasks.build(name: "Example task",
                                in_charge: "Example user",
                                status: "imcomplete",
                                post_group_id: @group.id)
    @task.save
    @record = @task.records.build(progress: "100%")
  end

  context "テストで使用するrecordが有効な値の時" do
    it "validになること" do
      expect(@record).to be_valid
    end
  end

  describe "supplementの有効性" do
    context "256文字以上の場合" do
      it "invalidになること" do
        @record.supplement = "a" *256
        expect(@record).to be_invalid
      end
    end
  end

  describe "progressの有効性" do
    context "空白の場合" do
      it "invalidになること" do
        @record.progress = " "
        expect(@record).to be_invalid
      end
    end
    context "51文字以上の場合" do
      it "invalidになること" do
        @record.progress = "a" *51
        expect(@record).to be_invalid
      end
    end
  end
end
