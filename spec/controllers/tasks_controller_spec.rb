require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  context "GET #index" do
    let!(:tasks) { create_list(:task, 2) }

    before :each do
      get :index
    end

    it "populates an array of tasks which have status 'in_work'" do
      expect(assigns(:tasks)).to match_array(tasks)
    end
  end
end
