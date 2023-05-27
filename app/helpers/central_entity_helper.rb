module CentralEntityHelper
  class << self

    def get_eligibility(claim_amount, claim_type, customer_id)
      health_record = HealthReport.find_by_person_id(customer_id)
      return false unless health_record
      health_record.insurance_policies.each do |policy|
        if policy.covers.contains(claim_type) && claim_amount <= policy.coverage.to_i
          return { eligible_policy_id: policy.id, max_coverage_left: policy.coverage, is_eligible: true }
        end
      end
      { is_eligible: false }
      # get uhid of customer
      # get health record
      # check insurances and it's active status
      # get claim amount, check if policy sum insured and
      # particular claim_type is under covers
    end

    def add_data_to_health_record(new_prescriptions, new_invoices, customer_id)
      health_report = HealthReport.find_by_person_id(customer_id)
      invoices = health_report.invoices
      invoices.add(new_invoices)
      prescriptions = health_report.prescriptions
      prescriptions.add(new_prescriptions)
      health_report.update(invoices: invoices, prescriptions: prescriptions)
    end

  end
end