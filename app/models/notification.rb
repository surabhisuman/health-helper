class Notification < ApplicationRecord
  belongs_to :person

  has_one :consultation

  TYPE = {
    "CONSENT": "CONSENT",
    "NOTICE": "NOTICE"
  }
end
