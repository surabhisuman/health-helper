class AddStatusToClaims < ActiveRecord::Migration[7.0]
  def change
    add_column :claims, :status, :string
  end
end
