class InsurancePolicy < ApplicationRecord
  has_many :claims
  belongs_to :health_report
end
