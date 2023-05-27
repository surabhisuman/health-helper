class Claim < ApplicationRecord
  belongs_to :consultation
  belongs_to :insurance_policy
  has_many :claim_status_histories
end
