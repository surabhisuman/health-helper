class Consultation < ApplicationRecord
  has_many :claims

  belongs_to :health_report

  has_many :prescriptions
  has_many :invoices
end
