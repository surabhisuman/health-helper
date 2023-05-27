class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.string :medicines, array: true
      t.string :lab_tests, array: true
      t.string :transcript
      t.string :prescription_detail
      t.integer :health_report_id, required: true
      t.references :consultation, index: true, foreign_key: true
      t.timestamps
    end
  end
end
