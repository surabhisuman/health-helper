class Consent < ApplicationRecord
  belongs_to :person
  belongs_to :consultation
end
