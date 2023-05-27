class InsurancePoliciesController < ApplicationController
  before_action :set_insurance_policy, only: %i[ show update destroy ]

  # GET /insurance_policies
  def index
    @insurance_policies = InsurancePolicy.all

    render json: @insurance_policies
  end

  # GET /insurance_policies/1
  def show
    render json: @insurance_policy
  end

  # POST /insurance_policies
  def create
    @insurance_policy = InsurancePolicy.new(insurance_policy_params)

    if @insurance_policy.save
      render json: @insurance_policy, status: :created, location: @insurance_policy
    else
      render json: @insurance_policy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /insurance_policies/1
  def update
    if @insurance_policy.update(insurance_policy_params)
      render json: @insurance_policy
    else
      render json: @insurance_policy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /insurance_policies/1
  def destroy
    @insurance_policy.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_policy
      @insurance_policy = InsurancePolicy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def insurance_policy_params
      params.fetch(:insurance_policy, {})
    end
end
