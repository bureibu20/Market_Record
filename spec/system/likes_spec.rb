require 'rails_helper'

RSpec.describe 'いいねランキング機能', type: :system do

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

  describe 'いいねマーク' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'  
      find(".unlike-btn").click
    end

    context '記事にいいねをつけた場合' do
      it 'いいねマークが表示される' do
        expect(page).to have_content find(".like-btn")
      end
    end
  end
end