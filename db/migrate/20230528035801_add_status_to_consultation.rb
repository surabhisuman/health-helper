class AddStatusToConsultation < ActiveRecord::Migration[7.0]
  def change
    add_column :consultations, :status, :string
  end
end
