class AddCoverageToInsurancePolicy < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_policies, :coverage, :integer
  end
end
