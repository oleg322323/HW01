class PetitionsController < ApplicationController
  #фильтр для авторизированных
  before_filter :authorize, only: [:edit, :destroy]

  def new
    @petition = Petition.new
  end

  #POST /petitions
  def create
    # @petition = Petition.new(petition_params)
    @petition = current_user.petitions.build(petition_params)
    if @petition.save
      redirect_to @petition, notice: "Петиция создана!"
    else
      render "new"
    end
  end

  def index
    @petitions = {} #объявляем как пустой хешик, иначе ошибка
    if params[:user].nil? #нет ссылки на юзера
      if params[:count] == "all"
        @petitions[:type] = 0
        @petitions[:list] = Petition.all
        @petitions[:header] = "Все петиции"
      else
        @petitions[:type] = 1
        @petitions[:list] = Petition.all.last(10)
        @petitions[:header] = "Последние петиции"
      end
    else #есть (ссылка на странице ведёт на свой ид, но можно вставить чужой)
      @petitions[:list] = Petition.all.select{ |petition| petition.user_id.to_s == params[:user] }
      if !(current_user.nil?) && params[:user] == current_user.id.to_s
        @petitions[:type] = 2
        @petitions[:header] = "Мои петиции"
      else
        @petitions[:type] = 3
        @petitions[:header] = "Петиции пользователя #{User.find(params[:user]).last_name} #{User.find(params[:user]).first_name}"
      end
    end
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

  def destroy

  end

  private

  def petition_params
    params.require(:petition).permit(:title, :text)
  end
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

=end
