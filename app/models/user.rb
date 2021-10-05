class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes
  
  def liked_by?(article_id)
    likes.where(article_id: article_id).exists?
  end

  # def follow!(other_user)
  #   active_relationships.create!(followed_id: other_user.id)
  # end
  # #フォローしているかどうかを確認する
  # def following?(other_user)
  #   active_relationships.find_by(followed_id: other_user.id)
  # end
  # def unfollow!(other_user)
  #   active_relationships.find_by(followed_id: other_user.id).destroy
  # end

  mount_uploader :image, ImageUploader
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
  def self.admin_guest
    find_or_create_by!(name: '管理者ゲスト',email: 'admin_guest@example.com', admin: true) do |user|
      user.password = SecureRandom.alphanumeric()
    end
  end
end
