module InsuranceHelper
  class << self

    # check for customer consent on a loop - long polling/while true
    # if consent doesn't exist - register customer consent
    # if approved, store customer health data [later can be made accessible via api only for a limited time]
    # and register claim in database with pre-auth status
    def process_pre_auth(amount, claim_type, requester_id, customer_id)
      consent = Consent.find_by(person_id: customer_id, requested_by: requester_id)
      # a consent is valid for 2 days
      if consent && (Time.now-1.day..Time.now+2.days).cover?(consent.registered_on)
        # health_report = HealthReport.find_by_person_id(customer_id)
        eligibility = CentralEntityHelper.get_eligibility(amount, claim_type, customer_id).with_indifferent_access
        eligible_policy_id = eligibility[:eligible_policy_id]
        claim = Claim.create(status: "pre-auth-approved", person_id: customer_id, insurance_policy_id: eligible_policy_id)
        return { "success": true, "claim_id": claim.id, "customer_id": customer_id, msg: "Pre auth claim registered successfully" }
      else
        NotificationHelper.send_notification(requester_id, customer_id, "Pre Auth Request")
        # send notification
        return { "success": false, "msg": "Consent pending fom customer" }
      end
    end

    # submit new invoices and prescriptions to central DB
    # check if claim exists
    # check claim status if in a valid state
    # check eligible limit with insurance policy data
    # calls fraud detection engine
    # if fraud engine validates
    # mark claim as success
    # send notif to customer
    def send_claim_request(claim_id, amount, claim_type)
      #todo: add claim type to claim model
      claim = Claim.find_by(id: claim_id)
      if !claim || claim.status != 'pre-auth-approved'
        return {"success": false, msg: "customer not authorised, invalid claim status"}
      end
      eligibility = CentralEntityHelper.get_eligibility(amount, claim_type, claim.person_id)
      if eligibility[:is_eligible]
        updateClaimStatus("processing", claim)
        insured_policy = InsurancePolicy.find_by_id(eligibility[:eligible_policy_id])
        is_fraud = false # todo: replace with gpt call
        unless is_fraud
          updateClaimStatus("approved", claim)
          updated_coverage = insured_policy.coverage - amount
          insured_policy.update(coverage: updated_coverage)
          CentralEntityHelper.add_data_to_health_record([], [], [claim], claim.person_id)
          NotificationHelper.send_notification(insured_policy.insurer, claim.person_id, "Claim of Rs." + (amount.to_s) +" approved")
          return {"success": true, "msg": "Claim processed successfully"}
        end
      end
      updateClaimStatus("rejected", claim)
      NotificationHelper.send_notification(insured_policy.insurer, claim.person_id, "Claim of Rs." + amount +" rejected")
    end

    private

    def updateClaimStatus(new_status, claim)
      ClaimStatusHistory.create(transition_from: claim.status, transition_to: new_status, claim_id: claim.id)
      claim.update(status: new_status)
    end
  end
end