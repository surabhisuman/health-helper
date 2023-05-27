class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.references :health_report, index: true, foreign_key: true
      t.timestamps
    end
  end
end
