class HealthCareProviderController < ApplicationController
  # checks eligibility for current medication/to be claim
  def check_eligibility
    amount = params[:amount].to_i
    claim_type = params["claim_type"].to_s
    health_id = params[:health_id].to_s
    customer = Person.find_by_health_id(health_id)
    CentralEntityHelper.get_eligibility(amount, claim_type, customer.id)
  end

  def send_pre_auth_request
    amount = params[:amount].to_i
  end

  def send_claim_request

  end

end
