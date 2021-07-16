require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "Tag Model測試" do
    it '不能沒有name' do
      expect(FactoryBot.build(:tag, name: nil)).not_to be_valid
    end

    it "name不能重複" do
      tag1 = FactoryBot.create(:tag, name: 'test')
      tag2 = FactoryBot.build(:tag, name: 'test')
      expect(tag2).not_to be_valid
    end

    it 'name不能太長' do
      expect(FactoryBot.build(:tag, name: 't'*16)).not_to be_valid
    end

    it 'name不能太短' do
      expect(FactoryBot.build(:tag, name: 't')).not_to be_valid
    end
  end
end
