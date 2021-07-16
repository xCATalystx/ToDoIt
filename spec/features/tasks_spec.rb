require 'rails_helper'
require 'pry-rails'

RSpec.feature 'Task', type: :feature do
  describe 'Task Feature測試' do
    before(:each) do
      @user = FactoryBot.create(:user)
      signin(@user.email, @user.password)
      @task = FactoryBot.create(:task, user_id: @user.id)
    end

    scenario '新增task' do
      visit new_task_path
      fill_in 'task[title]', with: 'title'
      fill_in 'task[content]', with: 'content'

      click_button '新增Task'

      expect(page).to have_content('title')
      expect(page).to have_text('新增任務成功！')
    end

    scenario '刪除task' do
      visit root_path
      click_link '刪除'

      page.accept_alert

      except(page).to have_selector('.task-item', count: 0)
      except(page).to have_text('任務已刪除！')
    end

    scenario '設定priority' do
      visit edit_task_path(@task)
      select('高', from: task[priority])

      click_button '更新Task'

      expect(page).to have_content('高')
      expect(page).to have_text('任務更新成功！')
    end

    scenario '設定status' do
      visit edit_task_path(@task)
      select('待處理', from: task[status])
  
      click_button '更新Task'
  
      expect(page).to have_content('待處理')
      expect(page).to have_text('任務更新成功！')
    end

    scenario '設定priority' do
      visit edit_task_path(@task)
      fill_in 'task[all_tags]', with: '生日, 聚餐'
  
      click_button '更新Task'
  
      expect(page).to have_content('生日')
      expect(page).to have_content('聚餐')
      expect(page).to have_text('任務更新成功！')
    end
    
    scenario '設定due date' do
      visit edit_task_path(@task)
      select('2021', from: task[due_date(1i)])
      select('十一', from: task[due_date(2i)])
      select('25', from: task[due_date(3i)])
  
      click_button '更新Task'
  
      expect(page).to have_content('2021-11-25')
      expect(page).to have_text('任務更新成功！')
    end

    scenario '任務依建立時間排序' do
      new_task = FactoryBot.create(:task, user_id: @user.id)
      visit root_path

      tasks = page.all('.task-item')

      expect(task[0]).to have_content(new_task.title)
      expect(task[1]).to have_content(@task.title)
    end

    scenario '任務依priority排序' do
      medium_task = FactoryBot.create(:task, :task_medium, user_id: @user.id)
      low_task = FactoryBot.create(:task, :task_low, user_id: @user.id)
      visit root_path

      click_link '優先'
      expect(page).to have_selector('.task-item', count: 3)
      tasks = page.all('.task-item')
  
      expect(task[0]).to have_content(@task.title)
      expect(task[1]).to have_content(medium_task.title)
      expect(task[2]).to have_content(low_task.title)

      click_link '截止時間'
      expect(page).to have_selector('.task-item', count: 3)
      tasks = page.all('.task-item')

      expect(task[0]).to have_content(low_task.title)
      expect(task[1]).to have_content(medium_task.title)
      expect(task[2]).to have_content(@task.title)
    end

    scenario '任務依due date排序' do
      early_task = FactoryBot.create(:task, :task_early, user_id: @user.id)
      late_task = FactoryBot.create(:task, :task_late, user_id: @user.id)
      visit root_path
  
      click_link '截止時間'
      expect(page).to have_selector('.task-item', count: 3)
      tasks = page.all('.task-item')
    
      expect(task[0]).to have_content(early_task.title)
      expect(task[1]).to have_content(@task.title)
      expect(task[2]).to have_content(late_task.title)
  
      click_link '截止時間'
      expect(page).to have_selector('.task-item', count: 3)
      tasks = page.all('.task-item')
  
      expect(task[0]).to have_content(late_task.title)
      expect(task[1]).to have_content(@task.title)
      expect(task[2]).to have_content(early_task.title)
    end

    scenario '搜尋任務title' do
      visit root_path
      fill_in 'keyword', with: @task.title
      click_button '搜尋'

      expect(first('.task-item')).to have_content(@task.title)
    end
  end
end