class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.string :medicines, array: true
      t.string :lab_tests, array: true
      t.integer :health_report_id, required: true
      t.timestamps
    end
  end
end
