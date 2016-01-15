FactoryGirl.define do
  factory :task do
    title "Task #1"
    priority 3
    scheduled Date.today
  end
end
