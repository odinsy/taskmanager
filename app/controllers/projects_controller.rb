class ProjectsController < ApplicationController

  before_action :find_project, only: [:run, :complete, :show, :edit, :update, :destroy]

  def run
    @project.run!
    redirect_to :back
  end

  def complete
    @project.complete!
    redirect_to :back
  end

  def index
    @projects = Project.all
  end

  def completed
    @projects = Project.completed
  end

  def new
    @project = Project.new
  end

  def show
  end

  def edit
  end

  def create
    @project = Project.create(project_params)
    if @project.errors.empty?
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @project.update_attributes(project_params)
    if @project.errors.empty?
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def find_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, tasks_attributes: [:title, :priority])
    end

end
