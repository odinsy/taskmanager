require "rails_helper"

feature "Create a Project" do
  context "when user trying to create a project with valid attributes" do
    it "creates a project" do
      visit new_project_path
      fill_in "Title", with: "Project 1"
      click_on "Create Project"
      expect(page).to have_content "Project 1"
    end
  end
  context "When user trying to create a project with invalid attributes" do
    it "doesn't create a project" do
      visit new_project_path
      fill_in "Title", with: ""
      click_on "Create Project"
      expect(page).to have_content "can't be blank"
    end
  end
end

feature "View and edit a Project" do
  context "When user trying to view or edit a project" do
    let!(:project) { create(:project) }
    it "shows a project page" do
      visit project_path(project)
      expect(page).to have_content project.title
    end
    it "shows a page for edit a task" do
      visit edit_project_path(project)
      expect(page).to have_button "Update Project"
    end
  end
end
