class ChangeDataTypeForStatus < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :boolean
  end
end
