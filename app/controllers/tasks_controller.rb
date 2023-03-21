class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
    @tasks = Task.all.sort_deadline.page(params[:page]).per(5) if params[:sort_deadline] #sort_deadlineはモデルで定義
    @tasks = Task.all.sort_priority.page(params[:page]).per(5) if params[:sort_priority] #sort_priorityはモデルで定義
    
    if params[:task].present?     #fizz buzzの15→5→3の流れ
      if params[:task][:name].present? && params[:task][:status].present?  #nameとstatus両方検索の場合
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").page(params[:page]).per(5)
        @tasks = @tasks.where(status: params[:task][:status]).page(params[:page]).per(5)
      elsif params[:task][:name].present?                                  #nameだけの検索の場合
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").page(params[:page]).per(5)
      elsif params[:task][:status].present?                                #statusだけの検索の場合
        @tasks = Task.where(status: params[:task][:status]).page(params[:page]).per(5)
      end
    end  
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render :new
    end  
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end  
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  # def search
  #   @tasks = Task.where('name LIKE ?',"%#{params[:q]}%")
  # end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end
end
