class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true
  validates :article_id, presence: true

  # ストック一覧表示用  
  def self.get_stock_articles(user)
    self.where(user_id: user.id).map(&:article)
  end
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }
end
