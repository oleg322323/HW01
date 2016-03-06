class PetitionsController < ApplicationController
  #фильтр для неавторизированных
  before_filter :authorize, only: [:edit, :update]

  def index
    @petitions = Petition.all
  end

  def show

  end

  def edit

  end

  def update

  end
end
