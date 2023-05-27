class AddHealthReportToClaims < ActiveRecord::Migration[7.0]
  def change
    add_reference :claims, :health_report, index: true
  end
end
