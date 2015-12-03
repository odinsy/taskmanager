require "rails_helper"

feature "Create a subtask" do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user_id: user.id) }

  context "when user trying to create a subtask" do

    before :each do
      login("user@example.com", "password")
      visit task_path(task)
    end

    it "creates a subtask with valid attributes", js: true do
      fill_in "Title", with: "Subtask 1"
      click_on "Add Subtask"
      expect(page).to have_content "Subtask 1"
    end

    it "doesn't create a subtask with invalid attributes", js: true do
      fill_in "Title", with: "12"
      click_on "Add Subtask"
      expect(page).to_not have_content "12"
    end

  end

end
