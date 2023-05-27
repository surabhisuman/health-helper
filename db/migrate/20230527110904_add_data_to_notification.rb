class AddDataToNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :title, :string
    add_column :notifications, :data, :string
    add_column :notifications, :sender, :string
  end
end
