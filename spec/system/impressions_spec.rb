require 'rails_helper'

RSpec.describe '閲覧数ランキング機能', type: :system do
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
  
  describe '閲覧数機能' do
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
      visit article_path(@article)
      
    end
    context '記事を閲覧した場合' do
      it '閲覧数が表示される' do
        visit article_path(@article)
        visit article_path(@article)
        expect(find(".impression_rspec").text).to eq "閲覧数 3" 
      end
    end
  end
end