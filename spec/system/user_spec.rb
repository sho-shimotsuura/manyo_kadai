require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user2) { FactoryBot.create(:user2) }
  let!(:user) { FactoryBot.create(:user) }

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーページが表示される' do
        visit new_user_path
        fill_in "user_name", with: "User3"
        fill_in "user_email", with: "c@gmail.com"
        fill_in "user_password", with: "password1"
        fill_in "user_password_confirmation", with: "password1"
        click_on "Create my account"
        expect(page).to have_content "c@gmail.com"
      end
    end
  end

  describe 'ログイン確認' do
    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content "Log in"
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'ユーザーページが表示される' do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password1"
        click_on "Log in"
        expect(page).to have_content "a@gmail.com"
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぼうとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password1"
        click_on "Log in"
        visit user_path(user2)
        expect(page).to have_content '権限がありません'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトしようとした場合' do
      it 'ログアウトできること' do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password1"
        click_on "Log in"
        click_link "Logout"
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '管理者機能' do
    context '管理ユーザが管理画面にアクセス使用とした場合' do
      it 'アクセスできること' do
        visit new_session_path
        fill_in "session_email", with: "b@gmail.com"
        fill_in "session_password", with: "password2"
        click_on "Log in"
        click_on "管理者画面"
        expect(page).to have_content '管理者画面'
      end
    end
    context '一般ユーザが管理ページにアクセスしようとした場合' do
      it 'アクセスできないこと' do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password1"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content '管理者権限がありません'
      end
    end
    context '管理ページからユーザーの新規登録をしようとした場合' do
      it '登録できること' do
        visit new_session_path
        fill_in "session_email", with: "b@gmail.com"
        fill_in "session_password", with: "password2"
        click_on "Log in"
        click_on "管理者画面"
        click_on "Create New User"
        fill_in "user_name", with: "User3"
        fill_in "user_email", with: "c@gmail.com"
        fill_in "user_password", with: "password3"
        fill_in "user_password_confirmation", with: "password3"
        click_on "Create account"
        expect(page).to have_content "c@gmail.com"
      end
    end
    context '管理ページからユーザーの詳細ページにアクセスした場合' do
      it 'アクセスできる' do
        visit new_session_path
        fill_in "session_email", with: "b@gmail.com"
        fill_in "session_password", with: "password2"
        click_on "Log in"
        click_on "管理者画面"
        visit admin_user_path(user)
        expect(page).to have_content "a@gmail.com"
      end
    end
    context '管理者がユーザーの編集ページにアクセスした場合' do
      it 'アクセス/編集できる' do
        visit new_session_path
        fill_in "session_email", with: "b@gmail.com"
        fill_in "session_password", with: "password2"
        click_on "Log in"
        click_on "管理者画面"
        visit edit_admin_user_path(user)
        fill_in "user_name", with: "User3"
        fill_in "user_email", with: "c@gmail.com"
        fill_in "user_password", with: "password3"
        fill_in "user_password_confirmation", with: "password3"
        click_on "Update"
        expect(page).to have_content "c@gmail.com"
      end
    end
    context '管理者がユーザーを削除しようとした場合' do
      it '削除できること' do
        visit new_session_path
        fill_in "session_email", with: "b@gmail.com"
        fill_in "session_password", with: "password2"
        click_on "Log in"
        click_on "管理者画面"
        accept_alert do
          click_on 'Delete', match: :first
        end
        expect(page).not_to have_content 'a@gmail.com'
      end
    end
  end  
end  