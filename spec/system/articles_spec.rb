require 'rails_helper'

RSpec.describe '記事機能', type: :system do
  before do
    
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
    @tag = FactoryBot.create(:tag)
    @second_tag = FactoryBot.create(:second_tag)
  
    visit new_user_session_path
    fill_in 'user_email', with: 'user1@gmail.com'
    fill_in 'user_password', with: '1111111'
    click_button 'ログイン'
  end

  describe '新規作成機能' do
    before do
      visit new_article_path
      
      fill_in "article_title", with: "test_title"
      fill_in "article_content", with: "test_content"
      first("article_tag_ids_1").check
      click_button '登録する'
    end

    context '記事を新規作成した場合' do
      it '作成した記事が表示される' do
        expect(page).to have_content 'test_title'
      end
    end
  end
end
  