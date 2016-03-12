#sessions создавался генератором как контролллер, класса Session нету
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Вы вошли в систему"
    else
      flash.now.alert = "Email или пароль не найдены"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Вы вышли из системы"
  end
end
