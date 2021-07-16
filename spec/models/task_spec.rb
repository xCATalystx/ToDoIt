require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Task Model測試" do
    it "不能沒有title" do
      expect(FactoryBot.build(:task, title: nil, content: 'test')).not_to be_valid
    end

    it "不能沒有content" do
      expect(FactoryBot.build(:task, title: 'test', content: nil)).not_to be_valid
    end

    it "不能沒有title和content" do
      expect(FactoryBot.build(:task, title: nil, content: nil)).not_to be_valid
    end
  end
end