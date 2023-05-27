class HealthCareProviderController < ApplicationController

  # checks eligibility for current medication/to be claim
  def check_eligibility
    amount = params[:amount].to_i
    claim_type = params["claim_type"].to_s
    health_id = params[:health_id].to_s
    customer = Person.find_by_health_id(health_id)
    resp = CentralEntityHelper.get_eligibility(amount, claim_type, customer.id)
    return render json: resp
  end

  def send_pre_auth_request
    amount = params[:amount].to_i
    claim_type = params["claim_type"].to_s
    requester_id = params["requester_id"]
    health_id = params[:health_id].to_s
    customer = Person.find_by_health_id(health_id)
    resp = InsuranceHelper.process_pre_auth(amount, claim_type, requester_id, customer.id)
    return render json: resp
  end

  def update_docs_and_send_claim_request
    claim_id = params[:claim_id]
    amount = params[:claims_amount]
    claim_type = params[:claim_type]
    CentralEntityHelper.add_data_to_health_record(params[:prescriptions], params[:invoices], params[:person_id])
    resp = InsuranceHelper.send_claim_request(claim_id, amount, claim_type)
    return render json: resp
  end

end
