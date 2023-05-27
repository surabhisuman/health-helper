class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :amount
      t.integer :health_report_id, required: true
      t.references :consultation, index: true, foreign_key: true
      t.timestamps
    end
  end
end
