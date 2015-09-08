require 'rails_helper'

describe Task do

  let!(:task) { create(:task) }

  context "when created new task" do
    it "has status 'in_work'" do
      expect(task.status).to eq("in_work")
    end
  end

  context "when called method #run for task" do
    it "changes the status to 'completed'" do
      task.complete!
      expect(task.status).to eq("completed")
    end
    it "changes the status to 'in_work'" do
      task.update_attributes(status: "completed")
      task.run!
      expect(task.status).to eq("in_work")
    end
  end
end
