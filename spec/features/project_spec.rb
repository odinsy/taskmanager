require "rails_helper"

feature "Create the project" do

  let!(:user) { create(:user) }

  context "when user trying to create a project with valid attributes" do

    it "creates a project" do
      login("user@example.com", "password")
      visit new_project_path(user)
      fill_in "Title", with: "Project 1"
      click_on "Create Project"
      expect(page).to have_content "Project 1"
    end

  end

  context "When user trying to create a project with invalid attributes" do

    it "doesn't create a project" do
      login("user@example.com", "password")
      visit new_project_path(user)
      fill_in "Title", with: ""
      click_on "Create Project"
      expect(page).to have_content "can't be blank"
    end

  end

end

feature "View and edit the project" do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }

  context "When the user trying to view or edit the project" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows the project page" do
      visit project_path(project)
      expect(page).to have_content project.title
    end

    it "shows tasks on the project page" do
      task = create(:task, project_id: project.id, user_id: user.id)
      visit project_path(project)
      expect(page).to have_content task.title
    end

    it "shows the page for edit the project" do
      visit edit_project_path(project)
      expect(page).to have_button "Update Project"
    end

  end
  
end

feature "view the projects" do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }

  context "when the user has completed the project" do

    before :each do
      login("user@example.com", "password")
      visit project_path(project)
      click_on "Complete"
    end

    it "doesn't show the project on the projects page" do
      expect(page).to_not have_content project.title
    end

    it "shows the project on the completed projects page" do
      visit completed_projects_path
      expect(page).to have_content project.title
    end

  end

end
