def register(email, password, password_confirmation)
  visit new_registration_path
  fill_in :registration_email, with: email
  fill_in :registration_password, with: password
  fill_in :registration_password_confirmation, with: password_confirmation
  click_button "Register"
end
