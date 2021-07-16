require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Model測試' do
    it "不能沒有email" do
      expect(FactoryBot.build(:user, email: nil)).not_to be_valid
    end

    it "email不能重複" do
      user1 = FactoryBot.create(:user, email: 'user@mail.com')
      user2 = FactoryBot.build(:user, email: 'user@mail.com')
      expect(user2).not_to be_valid
    end

    it "email格式錯誤" do
        expect(FactoryBot.build(:user, email: user&mail.com)).not_to be_valid
    end
  end
end