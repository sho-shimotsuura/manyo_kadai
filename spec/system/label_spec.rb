require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:task2) { FactoryBot.create(:second_task, user: user) }
  let!(:label){FactoryBot.create(:label)}
  let!(:task_label) { FactoryBot.create(:task_label, task: task, label: label) }

  # before do
  #   visit new_session_path
  #   fill_in "session_email", with: 'a@gmail.com'
  #   fill_in "session_password", with: 'password1'
  #   click_on "Log in"
  # end

  describe '新規作成機能' do
    context 'タスクをラベル付きで新規作成した場合' do
      it '作成したタスクにラベル付きで表示される' do
        visit new_session_path
        fill_in "session_email", with: 'a@gmail.com'
        fill_in "session_password", with: 'password1'
        click_on "Log in"
        visit new_task_path
        fill_in 'task_name', with: 'new_task'
        fill_in 'task_content', with: 'new_content'
        fill_in 'task_deadline', with: Date.new(2023, 5, 4)
        select '着手中', from: 'task_status'
        select '中', from: 'task_priority'
        check "ラベル1"
        click_button '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
        expect(page).to have_content '2023-05-04'
        expect(page).to have_content '着手中'
        expect(page).to have_content '中'
        expect(page).to have_content 'ラベル1'
      end
    end
  end

  describe '編集機能' do
    context 'タスクとラベルを編集した場合' do
      it '編集したタスクとラベルが表示される' do
        visit new_session_path
        fill_in "session_email", with: 'a@gmail.com'
        fill_in "session_password", with: 'password1'
        click_on "Log in"
        visit edit_task_path(task)
        fill_in 'task_name', with: 'test title'
        fill_in 'task_content', with: 'test content'
        fill_in 'task_deadline', with: Date.new(2023, 5, 4)
        select '未着手', from: 'task_status'
        select '中', from: 'task_priority'
        check 'ラベル1'
        click_on '更新する'
        expect(page).to have_content 'test title'
        expect(page).to have_content 'test content'
        expect(page).to have_content '2023-05-04'
        expect(page).to have_content '未着手'
        expect(page).to have_content '中'
        expect(page).to have_content 'ラベル1'
      end
    end
  end

  describe '検索機能' do
    context 'ラベルのみで検索した場合' do
      it 'ラベルを含むタスクで絞り込まれる' do
        visit new_session_path
        fill_in "session_email", with: 'a@gmail.com'
        fill_in "session_password", with: 'password1'
        click_on "Log in"
        visit tasks_path
        fill_in 'task_label_title', with: 'ラベル1'
        click_button '検索'
        expect(page).to have_content 'ラベル1'
      end
    end
  end  
end  