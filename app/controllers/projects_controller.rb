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
    @projects = current_user.projects.active
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
      redirect_to @project
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
    @project.destroy
    redirect_to :back
  end

  private

    def find_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :scheduled, :deadline)
    end

end
