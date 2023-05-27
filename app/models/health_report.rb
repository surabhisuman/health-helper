class HealthReport < ApplicationRecord
  has_many :invoices
  has_many :insurance_policies
  has_many :prescriptions
  has_one :person
end
