class AddNotificationType < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :type, :string
    add_column :notifications, :consultation_id, :integer
  end
end
