module ChangeState

  extend ActiveSupport::Concern

  included do
    aasm :column => 'state' do
      state :active, :initial => true
      state :completed
      event :run do
        transitions :from => :completed, :to => :active
      end
      event :complete do
        transitions :from => :active, :to => :completed
      end
    end
  end

end
