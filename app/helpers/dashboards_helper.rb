module DashboardsHelper

	def completed_task(projectid)
		user_task_list = UserTask.where(:project_id => projectid,:task_status => 2)
	end

	def in_progress_task(projectid)
		user_task_list = UserTask.where(:project_id => projectid,:task_status => 1)
	end

	def new_task(projectid,task_ids_at_user_level)
		user_task_list = Task.where(:project_id => projectid).where.not(id: task_ids_at_user_level)
	end

	def task_detail(task_id)
		Task.find(task_id)
	end

	def project_detail(project_id)
		Project.find(project_id)
	end

	def user_detail(user_id)
		User.find(user_id)
	end
end
