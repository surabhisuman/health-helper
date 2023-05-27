class CentralEntityHelper
  class << self

    def process_pre_auth(amount, claim_type, customer_id)
      # check for customer consent on a loop - long polling/while true
      # if consent doesn't exist - register customer consent
      # if approved, store customer health data [later can be made accessible via api only for a limited time]
      # and register claim in database with pre-auth status
    end
  end
end