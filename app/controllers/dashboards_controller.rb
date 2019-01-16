class DashboardsController < ApplicationController
  def index
    if session[:user_role] == "Admin"
      @user_tasks_project_ids = UserTask.pluck(:project_id).uniq
      @user_tasks_project_ids = Project.pluck(:id).uniq
      @user_tasks = UserTask.where(:user_id => current_user.id)
    else
      @user_tasks = UserTask.where(:user_id => current_user.id)
    end
  end

  def edit
    @user_task = UserTask.find(params[:id])
    @project_name = Project.find(@user_task.project_id).project_name
    @task_detail = Task.find(@user_task.task_id)
    @task_name = @task_detail.task_name
    @task_description = @task_detail.task_description
    @task_status = UserTask::TASK_STATUS.map{|i| ["#{i[1]}",i[0]]}
  end

  def update

    @user_task = UserTask.find(params[:id])
    respond_to do |format|
      if @user_task.update(params.require(:user_task).permit(:task_status))
        format.html { redirect_to dashboards_path, notice: 'User dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
end
