class TasksController < ApplicationController

  before_action :find_task, only: [:edit, :update, :destroy, :show]

  def index
    @tasks = Task.order(id: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
        flash[:notice] = "新增任務成功！"
        redirect_to "/"
    else
        render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
        redirect_to "/", notice: '任務更新成功！'
    else
        render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to "/", notice: '任務已刪除！'
  end

  def show
    @note = Note.new
    @notes = @task.notes.order(id: :desc)
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find(params["id"])
  end
end