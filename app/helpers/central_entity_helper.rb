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

    def add_data_to_health_record(consultation, customer_id)
      health_report = HealthReport.find_by_person_id(customer_id)
      existing_consultations = health_report.consultations || []
      existing_consultations << consultation
      health_report.update(consultations: existing_consultations)
    end

  end
end