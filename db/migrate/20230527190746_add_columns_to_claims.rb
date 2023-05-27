class AddColumnsToClaims < ActiveRecord::Migration[7.0]
  # - Date of Service: 10th March, 2022
  # - Provider: Ruby Hall Clinic, Pune - already in place name change?todo didn;t get
  # - Diagnosis: Pregnancy
  # - Procedure: Caesarean section, Hospitalization (for 3 days)
  # - Claim Amount: ₹1,80,000 - already in place name change?todo
  # - Paid by Insurance: ₹1,62,000
  # - Out of Pocket: ₹18,000

  def change
    add_column :claims, :date_of_service, :timestamp
    add_column :claims, :diagnosis, :string
    add_column :claims, :procedure, :string
    add_column :claims, :provider, :string
    add_column :claims, :paid_by_insurance, :integer
    add_column :claims, :out_of_pocket, :integer
    add_column :claims, :consultation_id, :integer
  end
end
