require 'rails_helper'
require 'pry-rails'

RSpec.feature 'Task', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  scenario '註冊user' do
    visit sign_up_path
    sign_up('user@gmail.com', 'password')

    expect(page).to have_text('帳號建立成功！')
  end

  scenario 'user登入' do
    visit sign_in_path
    sign_in('user@gmail.com', 'password')

    expect(page).to have_text('成功登入！')
  end

  scenario '未登入不能進入任務管理頁面' do
    visit tasks_path
    expect(page).to redirect_to sign_in_path
  end

  scenario '只能看到當前使用者建立的任務' do
    user_task = FactoryBot.create(:task, user_id: @user.id)
    other_user = FactoryBot.create(:user, :other_user)
    other_user_task = FactoryBot.create(:task, user_id: other_user.id)

    visit sign_in_path
    sign_in(@user.email, @user.password)

    expect(page).not_to have_content(other_user_task.title)
    expect(page).to have_content(user_task.title)
  end
end