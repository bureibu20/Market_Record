require 'rails_helper'

RSpec.describe '記事投稿機能', type: :model do

  describe 'バリデーションのテスト' do
    before do
      @user = FactoryBot.create(:user1)
    end
    context 'タイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        article = Article.new(title: '', content: '失敗テスト')
        expect(article).not_to be_valid
      end
    end
    context '記事の詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        article = Article.new(title: "失敗テスト", content: "")
        expect(article).to be_invalid
      end
    end
    context '記事のタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        #@userはbeforeで作ったインスタンス変数
        article = Article.new(title: "テスト", content: "成功", user_id: @user.id)
        expect(article).to be_valid
      end
    end
  end

end