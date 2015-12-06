class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.integer :priority

      t.timestamps null: false
    end
  end
end
