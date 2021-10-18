require 'rails_helper'

RSpec.describe 'タグ機能', type: :system do

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

  describe 'タグ機能' do
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

    context '記事をタグをつけて新規作成した場合' do
      it '作成した記事が表示される' do
        expect(page).to have_content 'tag'
      end
    end
  end

  describe 'タグがない場合' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'
      visit new_article_path
      fill_in "article_title", with: "test_title"
      fill_in "article_content", with: "test_content"
      click_button '登録する'
    end
    context '記事にタグをつけなかった場合' do
      it '作成した記事にタグが表示されない' do
        expect(page).to_not have_content 'tag'
      end
    end
  end

end