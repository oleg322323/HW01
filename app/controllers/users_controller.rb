#user создавался генератором как ресурс, присутствует класс User
class UsersController < ApplicationController
  #GET /users/new
  def new
    @user = User.new
  end

  #POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id #залогинивает сразу после регистрации
      redirect_to root_url, notice: "Аккаунт создан"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
