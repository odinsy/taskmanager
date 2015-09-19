require 'rails_helper'

describe Task do

  let!(:task) { create(:task) }

  context "when created a new task" do
    it "has status 'in_work'" do
      expect(task.status).to eq("in_work")
    end
    it "valid if the title and priority are exist" do
      expect(task).to be_valid
    end
    it "do not valid if the title is not exist" do
      task.update_attributes(title: "")
      expect(task).to_not be_valid
    end
    it "do not valid if the priority is not exist" do
      task.update_attributes(priority: "")
      expect(task).to_not be_valid
    end
  end

  context "when called a method #run" do
    it "changes the status to 'in_work'" do
      task.update_attributes(status: "completed")
      task.run!
      expect(task.status).to eq("in_work")
    end
  end

  context "when called a method #complete" do
    it "changes the status to 'completed'" do
      task.complete!
      expect(task.status).to eq("completed")
    end
  end

  context "when the task was deleted" do
    it "deletes subtasks" do
      subtask = task.subtasks.create(title: "подзадача 2", priority: 3)
      task.destroy
      expect{Task.find(id: subtask.id)}.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

end
