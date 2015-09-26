class AddScheduledToProject < ActiveRecord::Migration
  def change
    add_column :projects, :scheduled, :date
  end
end
