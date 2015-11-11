require "rails_helper"

feature "Create a task" do

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }

  context "when user creating a task" do

    before :each do
      login("user@example.com", "password")
      visit new_task_path
    end

    it "creates a new task with valid attributes" do
      fill_in "Title", with: "Task 1"
      select Date.current.year, from: "task[scheduled(1i)]"
      select Date.today.strftime("%B"), from: "task[scheduled(2i)]"
      select Date.current.day, from: "task[scheduled(3i)]"
      select "High", from: "Priority"
      click_on "Create Task"
      expect(page).to have_content "Task 1"
    end

    it "doesn't create a new task with invalid attributes" do
      fill_in "Title", with: ""
      select Date.current.year, from: "task[scheduled(1i)]"
      select Date.today.strftime("%B"), from: "task[scheduled(2i)]"
      select Date.current.day, from: "task[scheduled(3i)]"
      select "High", from: "Priority"
      click_on "Create Task"
      expect(page).to have_content "can't be blank"
    end

  end

  context "when user creating a task on the Project page" do

    before :each do
      login("user@example.com", "password")
      visit project_path(project)
    end

    it "creates a new task with valid attributes", js: true do
      fill_in "Title", with: "Task 1"
      click_on "Add Task"
      expect(page).to have_content "Task 1"
    end

    it "doesn't create a new task with invalid attributes", js: true do
      fill_in "Title", with: "az"
      click_on "Add Task"
      expect(page).to_not have_content "az"
    end

  end

end

feature "View and edit a task" do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user_id: user.id) }

  context "when user trying to view or edit a task" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows a task's page" do
      visit task_path(task)
      expect(page).to have_content task.title
    end

    it "shows a page for edit the task" do
      visit edit_task_path(task)
      expect(page).to have_button "Update Task"
    end

  end

end

feature "Views tasks" do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user_id: user.id) }

  context "when user trying to view today's tasks" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows their" do
      visit tasks_path
      expect(page).to have_content task.title
    end

    it "doesn't show tomorrows tasks" do
      task.update_attributes(scheduled: Date.tomorrow)
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show scheduled task" do
      task.update_attributes(scheduled: Date.tomorrow + 1)
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show waiting task" do
      task.update_attributes(scheduled: "")
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show completed task" do
      task.complete!
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

  end

  context "when user trying to view tomorrows's tasks" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows their" do
      task.update_attributes(scheduled: Date.tomorrow)
      visit tomorrow_tasks_path
      expect(page).to have_content task.title
    end

    it "doesn't show today's tasks" do
      task.update_attributes(scheduled: Date.today)
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show scheduled task" do
      task.update_attributes(scheduled: Date.tomorrow + 1)
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show waiting task" do
      task.update_attributes(scheduled: "")
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show completed task" do
      task.complete!
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

  end

  context "when user trying to view scheduled tasks" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows their" do
      task.update_attributes(scheduled: Date.tomorrow + 1)
      visit scheduled_tasks_path
      expect(page).to have_content task.title
    end

    it "doesn't show today's tasks" do
      task.update_attributes(scheduled: Date.today)
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show tomorrows tasks" do
      task.update_attributes(scheduled: Date.tomorrow)
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show waiting task" do
      task.update_attributes(scheduled: "")
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show completed task" do
      task.complete!
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

  end

  context "when user trying to view waiting tasks" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows their" do
      task.update_attributes(scheduled: "")
      visit waiting_tasks_path
      expect(page).to have_content task.title
    end

    it "doesn't show today's tasks" do
      task.update_attributes(scheduled: Date.today)
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show tomorrows tasks" do
      task.update_attributes(scheduled: Date.tomorrow)
      visit tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show scheduled task" do
      task.update_attributes(scheduled: Date.tomorrow + 1)
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

    it "doesn't show completed task" do
      task.complete!
      visit tomorrow_tasks_path
      expect(page).to_not have_content(task.title)
    end

  end

  context "when user trying to view completed tasks" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows their" do
      task.complete!
      visit completed_path
      expect(page).to have_content task.title
    end

    it "doesn't show 'active' task" do
      visit completed_path
      expect(page).to_not have_content task.title
    end

  end

end
