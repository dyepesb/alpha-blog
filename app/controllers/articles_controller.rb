class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit 
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      # status: :unprocessable_entity found in https://gorails.com/forum/rails-for-beginners-part-14-handling-sign-up-errors-discussion to fix "form responses must redirect to another location" 
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated succesfully."
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # delete method needs: data: { turbo_method: :delete } not just method: :delete in index.html.erb
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
  @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
