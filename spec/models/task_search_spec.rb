require 'rails_helper'

RSpec.describe Task, type: :model do
  # Arrange
  before do
    user = User.create(email: 'test@gmail.com', password: 'azsxdcfv')
    user.tasks.create(title: 'test', content: "123")
    user.tasks.create(title: 'model', content: "abc")
    user.tasks.create(title: '測試', content: "測試")
  end
  it "搜尋關鍵字" do
    # Act
    result = Task.search('test')
  
    # Assert
    expect(result.count).to be 1
end
