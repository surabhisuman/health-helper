module InsuranceHelper
  class << self

    # check for customer consent on a loop - long polling/while true
    # if consent doesn't exist - register customer consent
    # if approved, store customer health data [later can be made accessible via api only for a limited time]
    # and register claim in database with pre-auth status
    def process_pre_auth(requester_id, customer_id, eligibility)
      health_report = HealthReport.find_by_person_id(customer_id)
      # create new consultation at time of pre-auth
      existing_consultations = health_report.consultations || []
      consultation = nil
      existing_consultations.each do |ec|
        if ec.status == 'pre-auth-approved'
          consultation = ec
          break
        end
      end
      consultation = Consultation.create(health_report: health_report, status: 'pre-auth-approved') if consultation.nil?
      consent = Consent.find_by(person_id: customer_id, consultation_id: consultation.id)
      # a consent is valid for 2 days
      if consent && (Time.now-1.day..Time.now+2.days).cover?(consent.registered_on)
        # health_report = HealthReport.find_by_person_id(customer_id)
        eligible_policy_id = eligibility[:eligible_policy_id]
        existing_claims = consultation.claims || []
        claim = nil
        existing_claims.each do |ec|
          if ec.status == 'pre-auth-approved'
            claim = ec
            break
          end
        end
        claim = Claim.create(status: "pre-auth-approved", person_id: customer_id, insurance_policy_id: eligible_policy_id, consultation_id: consultation.id) if claim.nil?
        return { "success": true, "claim_id": claim.id, "consultation_id": consultation.id, msg: "Pre auth claim registered successfully" }
      else
        NotificationHelper.send_notification(requester_id, customer_id, "Pre Auth Request", consultation.id, "CONSENT")
        # send notification
        claim = Claim.find_by(consultation_id: consultation.id, status: "pre-auth-approved")
        return { "success": false, "msg": "Consent pending fom customer", "claim_id": claim&.id, "consultation_id": consultation.id }
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
    def send_claim_request(claim_id, amount, eligibility)
      #add claim type to claim model
      claim = Claim.find_by(id: claim_id)
      if !claim || claim.status != 'pre-auth-approved'
        return {"success": false, msg: "customer not authorised, invalid claim status"}
      end
      fraud_response = nil
      if eligibility[:is_eligible]
        updateClaimStatus("processing", claim)
        insured_policy = InsurancePolicy.find_by_id(eligibility[:eligible_policy_id])
        # is_fraud = false #replace with gpt call
        medical_report = ClaimReportGenerator.new(claim.person_id).generate
        fraud_response = FraudDetectionService.detect(medical_report)
        if fraud_response[:approved] == "Yes"
          updateClaimStatus("approved", claim)
          updated_coverage = insured_policy.coverage - amount
          insured_policy.update(coverage: updated_coverage)
          NotificationHelper.send_notification(insured_policy.insurer, claim.person_id, "Claim of Rs." + (amount.to_s) +" approved", claim.consultation_id, "NOTICE")
          return {"success": true, "msg": "Claim processed successfully", fraud_detector_response: fraud_response}
        end
      end
      updateClaimStatus("rejected", claim)
      NotificationHelper.send_notification(insured_policy.insurer, claim.person_id, "Claim of Rs." + (amount.to_s) +" rejected", claim.consultation_id, "NOTICE")
      return {"success": false, "msg": "Claim rejected", fraud_detector_response: (fraud_response || {"summary": "Not eligible for claim"})}
    end

    private

    def updateClaimStatus(new_status, claim)
      ClaimStatusHistory.create(transition_from: claim.status, transition_to: new_status, claim_id: claim.id)
      claim.update(status: new_status)
    end
  end
end