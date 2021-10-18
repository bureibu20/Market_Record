require 'rails_helper'

RSpec.describe '記事機能', type: :system do
  before do
    @user = FactoryBot.create(:user1)
    @user2 = FactoryBot.create(:user2)
    @tag = FactoryBot.create(:tag1)
    @tag2 = FactoryBot.create(:tag2)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @article2 = FactoryBot.create(:article2, user_id: @user2.id)
    Tagging.create(tag_id: @tag.id, article_id:@article.id)
    Tagging.create(tag_id: @tag2.id, article_id:@article2.id)  
  end

  describe '新規作成機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'  
      visit new_article_path
      fill_in "article_title", with: "test_title"
      fill_in "article_content", with: "test_content"
      check "article_tag_ids_#{@tag.id}"
      click_button '登録する'
    end

    context '記事を新規作成した場合' do
      it '作成した記事が表示される' do
        expect(page).to have_content 'test_title'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン' 
      visit articles_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do 
        expect(page).to have_content 'test_title'
        expect(page).to have_content @user.name
      end
    end
    context '任意記事の詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit article_path(@article)
        expect(page).to have_content 'test_content'
      end
    end
  end
  describe '記事編集機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'  
      visit articles_path
      # click_link "/articles/@article.id/edit"
      # find(".glyphicon-edit").click
      all(".glyphicon-edit")[0].click
      fill_in "article_title", with: "edit_title"
      click_button '更新する'
    end
    context '記事の編集をした場合' do
      it '編集の内容が表示される' do
        expect(page).to have_content 'edit_title'
      end
    end
  end

  describe '記事削除機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'    
    end
    context '記事を削除した場合' do      
      it '削除表示がされる' do
        page.accept_confirm do
          all(".glyphicon-trash")[0].click
        end
        expect(page).to have_content '記事を削除しました'
      end
    end
  end

  describe '検索機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン' 
    end
    context '検索をした場合' do
      it "検索キーワードを含む記事で絞り込まれる" do
        fill_in 'search_title', with: 'test'
        click_button '検索'
        expect(page).to have_content 'test'
      end
      it "検索キーワードを含まない記事は表示されない" do
        fill_in 'search_title', with: 'test'
        click_button '検索'
        expect(page).not_to have_content 'article_a'
      end
    end
  end
end
  