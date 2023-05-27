class AddCoverageToInsurancePolicy < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_policies, :coverage, :string
  end
end
