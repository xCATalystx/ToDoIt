class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
        redirect_to "/"
    else
        render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
        redirect_to "/"
    else
        render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to "/"
  end

  def show
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find(params["id"])
  end
end
