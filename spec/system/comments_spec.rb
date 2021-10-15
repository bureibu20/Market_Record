require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
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
  describe 'コメント投稿機能' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: 'user1@gmail.com'
      fill_in 'user_password', with: '111111'
      click_button 'ログイン'  
      visit article_path(@article)
      binding.irb
      fill_in "コメントを入力する", with: "新しいコメント"
      click_button '投稿'
    end
    context 'コメントを投稿した場合' do
      it '投稿したコメントが表示される' do
        expect(page).to have_content '新しいコメント'
      end
    end
    context 'コメントを削除した場合' do
      it 'コメントが削除され表示されなくなる' do
        find(".delete-icon").click
        expect(page).not_to have_content '新しいコメント'
      end
    end
  end

end