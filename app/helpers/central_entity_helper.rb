class CentralEntityHelper
  class << self

    def get_eligibility(claim_amount, claim_type, customer_id)
      health_record = HealthReport.find_by_person_id(customer_id)
      return false unless health_record
      health_record.insurance_policies.each do |policy|
        if policy.covers.contains(claim_type) && claim_amount <= policy.coverage.to_i
          return true
        end
      end
      false
      # get uhid of customer
      # get health record
      # check insurances and it's active status
      # get claim amount, check if policy sum insured and
      # particular claim_type is under covers
    end

  end
end