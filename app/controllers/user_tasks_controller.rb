class UserTasksController < ApplicationController
  before_action :set_user_task, only: [:show, :edit, :update, :destroy]

  # GET /user_tasks
  # GET /user_tasks.json
  def index
    @user_tasks = UserTask.all
  end

  # GET /user_tasks/1
  # GET /user_tasks/1.json
  def show
  end

  # GET /user_tasks/new
  def new
    @user_task = UserTask.new
    @project_list = Project.all.map{|i| ["#{i.project_name}", i.id]}
    @task_list = []
  end

  # GET /user_tasks/1/edit
  def edit
    @user_task = UserTask.find(params[:id])
    @project_list = Project.all.map{|i| ["#{i.project_name}", i.id]}
    @task_list = Task.all.map{|i| ["#{i.task_name}", i.id]}
  end

  # POST /user_tasks
  # POST /user_tasks.json
  def create
    @user_task = UserTask.new(user_task_params)
    @user_task.task_status = 0
    respond_to do |format|
      if @user_task.save
        format.html { redirect_to user_tasks_path, notice: 'User task was successfully created.' }
        format.json { render :show, status: :created, location: @user_task }
      else
        format.html { render :new }
        format.json { render json: @user_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_tasks/1
  # PATCH/PUT /user_tasks/1.json
  def update
    respond_to do |format|
      if @user_task.update(user_task_params)
        format.html { redirect_to user_tasks_path, notice: 'User task was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_task }
      else
        format.html { render :edit }
        format.json { render json: @user_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_tasks/1
  # DELETE /user_tasks/1.json
  def destroy
    @user_task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url, notice: 'User task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def load_task
    if params[:project_id].present?
      @tasks = Project.find(params[:project_id]).tasks.map{|i| ["#{i.task_name}", i.id]}
      respond_to do |format|
        format.js 
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_task
      @user_task = UserTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_task_params
      params.require(:user_task).permit(:user_id,:project_id,:task_id,:task_status)
    end
end
