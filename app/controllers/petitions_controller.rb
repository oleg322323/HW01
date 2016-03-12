class PetitionsController < ApplicationController
  #фильтр для авторизированных
  before_filter :authorize, only: [:new, :edit, :destroy]

  def new
    @petition = Petition.new
  end

  #POST /petitions
  def create
    # @petition = Petition.new(petition_params)
    @petition = current_user.petitions.build(petition_params)
    if @petition.save
      redirect_to @petition, notice: "Петиция \"#{@petition.title}\" создана!"
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

  def update
    petition = Petition.find(params[:id])
    if petition.user != current_user.id #тест несанкционированного доступа
      redirect_to :back, alert: "Ошибка доступа"
    else
      name = petition.title
      if petition.update_attributes(petition_params)
        redirect_to petition, notice: "Петиция \"#{name}\" обновлена"
      else
        render "edit"
      end
    end
  end

  def destroy
    petition = Petition.find(params[:id])
    if petition.user != current_user.id
      redirect_to :back, alert: "Ошибка доступа"
    else
      name = petition.title
      petition.destroy
      redirect_to petitions_path( user: current_user ), alert: "Петиция \"#{name}\" удалена"
    end
  end

  private

  def petition_params
    params.require(:petition).permit(:title, :text)
  end
end