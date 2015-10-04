FactoryGirl.define do
  factory :user do
    email "user@example.com"
    name "User"
    password "password"
    password_confirmation { password }
  end
end
