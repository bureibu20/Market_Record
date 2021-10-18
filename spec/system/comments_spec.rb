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
    end
    context 'コメントを投稿した場合' do
      it '投稿したコメントが表示される' do
        visit article_path(@article)
        fill_in "comment_content", with: "テストコメント"
        click_button '登録する'
        expect(page).to have_content 'テストコメント'
      end
    end
    context 'コメントを削除した場合' do
      it 'コメントが削除され表示されなくなる' do
        visit article_path(@article)
        fill_in "comment_content", with: "テストコメント"
        click_button '登録する'
        page.accept_confirm do
          all(".glyphicon-trash")[0].click
        end
        expect(page).not_to have_content 'テストコメント'
      end
    end
  end
end