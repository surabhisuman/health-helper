class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :person, index: true, foreign_key: true
      t.timestamps
    end
  end
end
