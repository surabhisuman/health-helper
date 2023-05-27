class HealthReport < ApplicationRecord
  has_many :consultations
  has_many :insurance_policies
  belongs_to :person
end