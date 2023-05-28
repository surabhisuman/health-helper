require_relative '../helpers/consultation_helper'
require_relative '../helpers/central_entity_helper'
class HealthCareProviderController < ApplicationController
  extend ConsultationHelper
  extend CentralEntityHelper

  # checks eligibility for current medication/to be claim
  def check_eligibility
    amount = params[:amount].to_i
    claim_type = params[:claim_type].to_s
    health_id = params[:health_id].to_s
    customer = Person.find_by_health_id(health_id)
    resp = CentralEntityHelper.get_eligibility(amount, claim_type, customer.id)
    render json: resp
  rescue StandardError => e
    puts(e.message)
    render json: {msg: "no data available", is_eligible: false}
  end

  def send_pre_auth_request
    amount = params[:amount].to_i
    claim_type = params["claim_type"].to_s
    requester_id = params["requester_id"]
    health_id = params["health_id"].to_s
    customer = Person.find_by_health_id(health_id)
    eligibility = CentralEntityHelper.get_eligibility(amount, claim_type, customer.id).with_indifferent_access
    resp = InsuranceHelper.process_pre_auth(requester_id, customer.id, eligibility)
    render json: resp
  rescue StandardError => e
    puts(e.message)
    render json: {msg: "Bad request"}
  end

  def update_docs_and_send_claim_request
    claim_id = params[:claim_id].to_i
    amount = params[:amount].to_i
    claim_type = params[:claim_type].to_s
    health_id = params["health_id"].to_s
    customer = Person.find_by_health_id(health_id)
    eligibility = CentralEntityHelper.get_eligibility(amount, claim_type, customer.id)
    resp = InsuranceHelper.send_claim_request(claim_id, amount, eligibility)
    claim = Claim.find_by(id: claim_id)
    ConsultationHelper.add_data_to_consultation(params[:prescriptions], params[:invoices], [claim], claim.consultation_id)
    #todo: debug low priority why above line wasn't working
    consultation = claim.consultation
    CentralEntityHelper.add_data_to_health_record(consultation, customer.id)
    render json: resp
  rescue StandardError => e
    puts(e.message)
    render json: {msg: "Bad request"}
  end

end
