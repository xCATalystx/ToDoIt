class TasksController < ApplicationController
  before_action :require_user
  before_action :find_my_task, only: [:edit, :update, :destroy]

  def search
    keyword = params[:keyword]
    @tasks = @q.result(distinct: true).search(keyword).page(params[:page]).per(5)
  end

  def index
    @tasks = @q.result(distinct: true).page(params[:page]).per(5).order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Current.user.tasks.new(task_params)

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
    @task = Task.find(params["id"])
    @notes = @task.notes.order(id: :desc)
  end

  private
  def task_params
    params.require(:task).permit(:priority, :status, :tag, :title, :due_date, :content)
  end

  def find_my_task
    @task = Current.user.tasks.find(params["id"])
  end

  def self.priority_order
    order("
      case
        when priority = '高' then '3'
        when priority = '中' then '2'
        when priority = '低' then '1'
      end
    ")
  end
end
