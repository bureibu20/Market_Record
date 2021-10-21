class LikesController < ApplicationController
  before_action :article_params

  def create
    Like.create(user_id: current_user.id, article_id: params[:id])
  end

  def create_stock
    Like.create(user_id: current_user.id, article_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, article_id: params[:id]).destroy
  end

  def destroy_stock
    Like.find_by(user_id: current_user.id, article_id: params[:id]).destroy
  end

  private
  def article_params
    @article = Article.find(params[:id])
  end
end
