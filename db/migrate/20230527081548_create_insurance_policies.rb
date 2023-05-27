class CreateInsurancePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :insurance_policies do |t|
      t.string :insurer
      t.timestamp :start_date
      t.timestamp :end_date
      t.integer :sum_insured
      t.string :covers, array: true
      t.timestamps
    end
  end
end
