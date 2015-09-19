require "rails_helper"

feature "Create a task" do

  context "when user trying to create a task with valid attributes" do
    it "creates the new task" do
      visit new_task_path
      fill_in "Title", with: "Task 1"
      select Date.current.year, from: "task[scheduled(1i)]"
      select Date.today.strftime("%B"), from: "task[scheduled(2i)]"
      select Date.current.day, from: "task[scheduled(3i)]"
      select "High", from: "Priority"
      click_on "Create Task"
      expect(page).to have_content "Task 1"
    end
  end

  context "when user trying to create a task with invalid attributes" do
    it "doesn't create the new task" do
      visit new_task_path
      fill_in "Title", with: ""
      select Date.current.year, from: "task[scheduled(1i)]"
      select Date.today.strftime("%B"), from: "task[scheduled(2i)]"
      select Date.current.day, from: "task[scheduled(3i)]"
      select "High", from: "Priority"
      click_on "Create Task"
      expect(page).to have_content "can't be blank"
    end
  end

end

feature "View and edit a task" do

  context "when user trying to view or edit the task" do
    let!(:task) { create(:task) }
    it "shows the task's page" do
      visit task_path(task)
      expect(page).to have_content task.title
    end
    it "shows the page for edit the task" do
      visit edit_task_path(task)
      expect(page).to have_button "Update Task"
    end
  end

end

feature "Views tasks" do

  let!(:task) { create(:task) }

  context "when user trying to view today's tasks" do

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
    it "shows their" do
      task.complete!
      visit completed_tasks_path
      expect(page).to have_content task.title
    end
    it "doesn't show 'in_work' task" do
      visit completed_tasks_path
      expect(page).to_not have_content task.title
    end
  end

end

feature "Create a subtask" do

  let!(:task) { create(:task) }

  context "when user trying to create a subtask" do

    before :each do
      visit task_path(task)
    end

    it "creates a subtask with valid attributes" do
      fill_in "Title", with: "Subtask 1"
      click_on "Добавить подзадачу"
      expect(page).to have_content "Subtask 1"
    end
    it "doesn't create a subtask with invalid attributes" do
      fill_in "Title", with: ""
      click_on "Добавить подзадачу"
      expect(page).to_not have_content "123"
    end

  end

end
