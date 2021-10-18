require 'rails_helper'

RSpec.describe 'ユーザー登録機能', type: :model do

  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user1)
        user.name = ""
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user1)
        user.email = ""
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user1)
        user.password = ""
        expect(user).not_to be_valid
      end
    end
    context '名前が20文字以上の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user1)
        user.name = "a" * 25
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが50文字以上の場合' do
      it 'バリデーションに引っかかる' do
        user = FactoryBot.create(:user1)
        user.email = "a" * 50 + "@" + "gmail.com"
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが50文字以下の場合' do
      it '登録される' do
        user = FactoryBot.create(:user1)
        user.email = "a" * 40 + "@" + "gmail.com"
        expect(user).to be_valid
      end
    end
    context '名前とメールアドレスとパスワードが内容が入力されている場合' do
      it '登録される' do
        user = User.new(name: "test", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
        expect(user).to be_valid
      end
    end
  end

end