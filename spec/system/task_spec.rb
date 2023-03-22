require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task) }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with:'タスク名'
        fill_in 'task_content', with:'タスク詳細'
        fill_in 'task_deadline', with: Date.new(2023, 3, 10)
        select '着手中', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '2023-03-10'
        expect(page).to have_content '着手中'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit tasks_path
    end  
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task_name'
        expect(page).to have_content 'test_content'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_name2'
        expect(task_list[1]).to have_content 'task_name'
      end
    end  
  end
  
  describe '終了期限ソート機能' do
    context 'タスクが終了期限の降順で並んでいる場合' do
      it '期限が先のタスクが一番上に表示される' do
        visit tasks_path
        click_button '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_name2'
      end  
    end
  end

  describe '優先順位ソート機能' do
    context 'タスクが優先順位の降順で並んでいる場合' do
      it '優先順位が高いタスクが一番上に表示される' do
        visit tasks_path
        click_button '優先順位でソートする'
        sleep(0.5)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '高'
      end  
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content 'task_name'
        expect(page).to have_content 'test_content'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルで検索する場合' do
      it'検索結果に該当するタスクが表示される' do 
        visit tasks_path
        fill_in 'task_name', with: 'task_name'
        click_button '検索'
        expect(page).to have_content 'task_name'
      end
    end
    context 'ステータスで検索する場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        visit tasks_path
        select "着手中", from: 'task_status'
        click_button "検索"
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        visit tasks_path
        fill_in 'task_name', with: 'task_name'
        select '着手中', from: 'task_status'
        click_button '検索'
        expect(page).to have_content 'task_name'
        expect(page).to have_content '着手中'
      end
    end
  end  
end