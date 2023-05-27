module CentralEntityHelper
  class << self

    def get_eligibility(claim_amount, claim_type, customer_id)
      health_report = HealthReport.find_by_person_id(customer_id)
      return { is_eligible: false } unless health_report
      health_report.insurance_policies.each do |policy|
        if policy.covers.include?(claim_type.downcase) && claim_amount <= policy.coverage.to_i
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

    def add_data_to_health_record(new_prescriptions, new_invoices, new_claims, customer_id)
      health_report = HealthReport.find_by_person_id(customer_id)
      invoices = health_report.invoices
      prescriptions = health_report.prescriptions
      new_invoices.each do |ninv|
        invoices.add(Invoice.create(amount: ninv[:amount], health_report: health_report))
      end
      new_prescriptions.each do |npr|
        prescriptions.add(Prescription.create(medicines: npr[:medicines], lab_tests: npr[:lab_tests], health_report: health_report))
      end
      claims = health_report.claims
      claims.add(new_claims)
      health_report.update(invoices: invoices, prescriptions: prescriptions, claims: claims)
    end

  end
end