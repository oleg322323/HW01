class PetitionsController < ApplicationController
  #фильтр для авторизированных
  before_filter :authorize, only: [:edit]

  def new

  end

  def index
    @petitions = Petition.all
  end

  def all

  end

  def my

  end

  def show
    @petition = Petition.find(params[:id])
  end

  def edit
    @petition = Petition.find(params[:id])
  end

  # def update
  #   @petition = Petition.find(params[:id])
  #   if @petition.update_attributes(params[:petition])
  #     redirect_to @petition, notice: "Petition has been updated."
  #   else
  #     render "edit"
  #   end
  # end
end

=begin
class ArticlesController < ApplicationController
  #GET /articles
  def index
    #если тут нет render, выводит шаблон (то что в папке articles в index.html)
    # render json: session
    @articles = Article.all
    # render json: @articles
  end

  #GET /articles/1
  def show
    #render json: params
    #session['id'] = params[:id]
    # render json: params[:id]
    @article = Article.find(params[:id])
  end

  #PUT /articles/1
  def update
    article = Article.find(params[:id])
    article.update(params)
    redirect_to article_path(article)
  end

  #POST /articles
  def create
    article = Article.create(article_params)
    redirect_to article_path(article)
  end

  #GET /articles/new
  def new
    @article = Article.new
  end

  #
  def destroy

  end

  #нестандартный - определяется в блоке в routes
  #GET /articles/1/publish
  def publish

  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
=end
