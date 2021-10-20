class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!, except: :top, except: :guide
  before_action :authenticate_user!, except: [:top, :guide]
  impressionist actions: [:index, :show]

  
  def index
    @articles = Article.all.order(created_at: "DESC")
    @rank_articles = Article.order(impressions_count: 'DESC')
    @articles = Article.all.search_title(params[:search_title]).page(params[:page]) if params[:search_title].present? 
    
  end

  def show
    @article = Article.find(params[:id])
    impressionist(@article, nil, unique: [:ip_address]) 
    @comments = @article.comments
    @comment = @article.comments.build
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params) 

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "記事を作成しました" }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "記事を更新しました" }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "記事を削除しました" }
      format.json { head :no_content }
    end
  end

  def top
  end

  def guide
  end

  def iine_rank
  end
  
  def trend_line
  end

  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :impressions_count, :user_id, { tag_ids: [] })
    end
    
end
