require 'rails_helper'

RSpec.describe Task, type: :model do

  before do
    @user = create(:user)
    @group = @user.leader_groups.build(name: "Example Group")
    @group.save
    @task = @user.tasks.build(name: "Example task",
                                in_charge: "Example user",
                                status: "imcomplete",
                                post_group_id: @group.id)
  end

  context "テストで使用するtaskが有効な値の時" do
    it "validになること" do
      expect(@task).to be_valid
    end
  end

  describe "nameの有効性" do
    context "空白の場合" do
      it "invalidになること" do
        @task.name = " "
        expect(@task).to be_invalid
      end
    end
    context "50文字以上の場合" do
      it "invalidになること" do
        @task.name = "a" * 51
        expect(@task).to be_invalid
      end
    end
  end

  describe "in_chargeの有効性" do
    context "50文字以上の場合" do
      it "invalidになること" do
        @task.in_charge = "a" * 51
        expect(@task).to be_invalid
      end
    end
  end

  describe "statusの有効性" do
    context "空白の場合" do
      it "invalidになること" do
        @task.status = " "
        expect(@task).to be_invalid
      end
    end
  end


end
