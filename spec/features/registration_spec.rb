require "rails_helper"

describe "the registration proccess" do

  it "registers an user when data are correct" do
    register("user@example.com", "user", "password", "password")
    expect(page).to have_content "Tasks"
  end

  it "doesn't registers when user exists" do
    @user = create(:user)
    register("user@example.com", "user", "password", "password")
    expect(page).to have_content "Registration failed! "
  end

  it "doesn't registers when password and password confirmation are different" do
    register("user@example.com", "user", "password", "pass")
    expect(page).to have_content "Registration failed!"
  end

end
