module ConsultationHelper
  class << self

    def add_data_to_consultation(new_prescriptions, new_invoices, new_claims, consultation_id)
      consultation = Consultation.find_by_id(consultation_id)
      invoices = consultation.invoices.to_a
      prescriptions = consultation.prescriptions.to_a
      new_invoices.each do |ninv|
        invoices << Invoice.create(amount: ninv[:amount], consultation: consultation)
      end
      new_prescriptions.each do |npr|
        prescriptions << Prescription.create(medicines: npr[:medicines], lab_tests: npr[:lab_tests], consultation: consultation)
      end
      claims = consultation.claims.to_a
      if new_claims
        new_claims.each do |nc|
          claims << nc
        end
      end
      consultation.update(invoices: invoices, prescriptions: prescriptions, claims: claims, status: 'completed')
      return consultation
    end

    def create_or_update_consultation(health_report)
      Consultation.create(health_report: health_report)
    end
  end
end