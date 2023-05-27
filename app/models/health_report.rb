class HealthReport < ApplicationRecord
  has_many :invoices
  has_many :insurance_policies
  has_many :prescriptions
  belongs_to :person
end
