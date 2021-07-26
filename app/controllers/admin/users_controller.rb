class Admin::UsersController < ApplicationController
  helper_method :count
  before_action :find_user, only:[:edit, :show, :update, :destroy]
  
  def index
    @users = User.all.order(id: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "user was successfully created"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:notice] = "user was sucessfully updated"
    else
        render :edit
    end
  end

  def destroy
    @user.destroy 
    flash[:notice] = "user was successfully deleted"
    redirect_to admin_users_path
  end

  def show
    @task = Task.new
    @tasks = @user.tasks.order(id: :desc)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
  def find_user  
    @user = User.find(params["id"])
  end
end