class ProjectsController < ApplicationController

  before_action :find_project, only: [:run, :complete, :show, :edit, :update, :destroy]

  def run
    @project.run!
    redirect_to projects_path
  end

  def complete
    @project.complete!
    redirect_to projects_path
  end

  def index
    @projects = current_user.projects.active
  end

  def completed
    @projects = current_user.projects.completed
  end

  def new
    @project = current_user.projects.build
  end

  def show
  end

  def edit
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.errors.empty?
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    puts project_params
    @project.update_attributes(project_params)
    if @project.errors.empty? || :tasks_attributes?
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to :back
  end

  private

    def find_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :scheduled, :deadline, tasks_attributes: [:title, :user_id])
    end

end
