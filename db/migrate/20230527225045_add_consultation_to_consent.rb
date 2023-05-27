class AddConsultationToConsent < ActiveRecord::Migration[7.0]
  def change
    add_reference :consents, :consultation, index: true
  end
end
