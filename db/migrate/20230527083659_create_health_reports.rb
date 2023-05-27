class CreateHealthReports < ActiveRecord::Migration[7.0]
  def change
    create_table :health_reports do |t|
      t.references :person, index: true, foreign_key: true
      # t.has_many :invoices
      # t.has_many :prescriptions
      # t.has_many :insurance_policies
      t.timestamps
    end
  end
end
