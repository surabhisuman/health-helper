class ClaimReportGenerator
  def initialize(person_id)
    @person = Person.find_by(id: person_id)
    @health_report = @person.health_report
    @consultations = @health_report.consultations
    @claims = Claim.where(person_id: person_id)
    @prescriptions = Prescription.where(health_report_id: @health_report.id)
  end

  REPORT_TEMPLATE = "
%{insurance_claim_history}

%{medical_history}

%{transcript}

%{prescription}"

  def generate()
    REPORT_TEMPLATE % {
      insurance_claim_history: insurance_claim_history,
      medical_history: medical_history,
      transcript: transcript,
      prescription: prescription
    }
  end

  private

  CLAIM_HISTORY_TEMPLATE = "
Claim %{index} - %{year_of_claim}
Insurance Provider: %{insurance_provider}
- Date of Service: %{date_of_claim}
- Provider: %{health_care_provider}
- Diagnosis: %{diagnosis}
- Procedure: %{procedure}
- Claim Amount: ₹%{amount}
- Paid by Insurance: ₹%{paid_by_insurance}
- Out of Pocket: ₹%{out_of_pocket}
"

  def insurance_claim_history
    history = "###Patient Insurance Claim History:"
    @claims.each_with_index do |claim, index|
      claim_data = CLAIM_HISTORY_TEMPLATE % {
        index: index + 1,
        year_of_claim: claim.date_of_service.year,
        insurance_provider: claim.insurance_policy.insurer,
        date_of_claim: claim.date_of_service.strftime("%b %d, %Y"),
        health_care_provider: claim.provider,
        diagnosis: claim.diagnosis,
        procedure: claim.procedure,
        amount: claim.amount,
        paid_by_insurance: claim.paid_by_insurance,
        out_of_pocket: claim.out_of_pocket
      }
      history += claim_data
    end
    return history
  end

  def medical_history # TODO: need medical history data set
    ##Patient Medical History:
  end

  def transcript
    "###Patient Medical History: \n" + @prescriptions.first.transcript
  end

  def prescription
    "###Doctor's Prescription: \n" + @prescriptions.first.prescription_detail
  end
end