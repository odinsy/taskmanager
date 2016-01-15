require "rails_helper"

describe "show/edit user page" do

  let!(:user) { create(:user) }

  context "when user is logged in" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows user edit page" do
      visit edit_profile_path(user)
      expect(page).to have_content "Изменить профиль"
    end

    it "shows user page" do
      visit profile_path(user)
      expect(page).to have_content user.email
    end

  end

  context "when user is not logged" do

    it "doesn't shows the user's page" do
      visit profile_path(user)
      expect(page).to have_content "You have to authenticate to access this page."
    end

    it "doesn't shows the edit page" do
      visit edit_profile_path(user)
      expect(page).to have_content "You have to authenticate to access this page."
    end

  end

end
