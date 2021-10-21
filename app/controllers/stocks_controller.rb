class StocksController < ApplicationController
  before_action :authenticate_user!, except: :top
  def index
    # ログインユーザーがストックした記事一覧を取得
    stock_articles = Stock.get_stock_articles(current_user)
    # 取得した記事を10件毎にページネーションさせるためにpaginate_arrayメソッドを使う
    @stock_articles = Kaminari.paginate_array(stock_articles).page(params[:page]).per(10)
    @stocks = current_user.stocks    
    
    # @stocks = Stock.all.search_title(params[:search_title]).page(params[:page]) if params[:search_title].present? 
  end
  # def index
  #   @articles = Article.all
  #   @articles = current_user.articles.search_title(params[:search_title]).page(params[:page]) if params[:search_title].present? 
  # end

  def create
   @article = Article.find(params[:article_id])
   # 取得した記事がまだストックされていなければ
   unless @article.stocked?(current_user)
     # ログインしているユーザーを取得してparamsで渡された記事をストック
     @article.stock(current_user)
     # ajaxでストックボタンを実装
     respond_to do |format|
       format.html { redirect_to request.referrer || root_url }
       format.js
     end
   end
  end

  def destroy
   @article = Stock.find(params[:id]).article
   # 取得した記事が既にストックされていれば
   if @article.stocked?(current_user)
     # ログインしているユーザーを取得してparamsで渡された記事のストック解除
     @article.unstock(current_user)
     # ajaxでストックボタンを実装
     respond_to do |format|
       format.html { redirect_to request.referrer || root_url }
       format.js
     end
   end
  end
  def guide
  end
end
