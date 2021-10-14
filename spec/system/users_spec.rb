require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      before do
        visit new_user_registration_path
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test_user@dic.com'
        fill_in 'user_password', with: '111111'
        fill_in 'user_password_confirmation', with: '111111'
        click_button 'アカウント登録'
      end
      it '登録完了の表示がされる' do
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_content '記事を投稿する'
      end
    end
  end

  describe 'セッション機能' do
    before do
      @user = User.create(name: "test", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
      visit new_user_session_path
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: '123456'
      click_button 'ログイン'
    end
    context 'ユーザーがログインをした場合' do
      it 'ログインが表示がされる' do
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ユーザーがログインをした場合' do
      it 'menuアイコンが表示がされる' do
        expect(find(".fa-address-card") == all('i')[0]).to eq true
      end
    end
  end
  
  describe 'ログイン確認機能' do
    context 'ログイン後アカウント編集' do
      before do
        @user = User.create(name: "test", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
        visit new_user_session_path
        fill_in 'user_email', with: 'test@gmail.com'
        fill_in 'user_password', with: '123456'
        click_button 'ログイン'
      end
      it '自身のプロフィールを編集することができる' do
        visit articles_path
        find(".dropdown-toggle").click
        click_link 'アカウント編集'
        fill_in 'user_profile', with: 'はじめまして'
        fill_in 'user_current_password', with: '123456'
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
      it 'ログインアウトを実行できる' do
        visit articles_path
        find(".dropdown-toggle").click
        click_link 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
      end
    end
    context 'ユーザーがログインしていない場合' do
      it '記事一覧に飛ぼうとした時、ログイン画面に遷移すること' do
      visit articles_path
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end    
  end 
  describe '管理画面のテスト' do
    before do
      @user = User.create(name: "test", email: "test@gmail.com", password: "123456", password_confirmation: "123456", admin: "true")
      @user_second = User.create(name: "test2", email: "test2@gmail.com", password: "123456", password_confirmation: "123456", admin: "false" )
      visit new_user_session_path
    end
    context '管理ユーザは管理画面にアクセスできること' do
      
      it '管理ユーザは管理画面にアクセスできること' do
        fill_in 'user_email', with: 'test@gmail.com'
        fill_in 'user_password', with: '123456'
        click_button 'ログイン'
        visit articles_path
        find(".dropdown-toggle").click
        click_link '管理画面'
        expect(page).to have_content 'サイト管理'
      end
    end
    context '一般ユーザは管理画面にアクセスできないこと' do
      it '一般ユーザは管理画面にアクセスできないこと' do
        fill_in 'user_email', with: 'test2@gmail.com'
        fill_in 'user_password', with: '123456'
        click_button 'ログイン'
        visit articles_path
        find(".dropdown-toggle").click
        expect(page).to_not have_content '管理画面'
      end
    end
  end
  describe 'ゲストログイン機能' do
    before do
      @user = User.create(name: "test", email: "test@gmail.com", password: "123456", password_confirmation: "123456", admin: "true")
      @user_second = User.create(name: "test2", email: "test2@gmail.com", password: "123456", password_confirmation: "123456", admin: "false" )
    end
    context '管理者ゲストログインをした場合' do
      it 'ゲストログインができる' do
        visit root_path
        click_link 'ゲストログイン'
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
  end
end