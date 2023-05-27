class ClaimsController < ApplicationController
  before_action :set_claim, only: %i[ show update destroy ]

  # GET /claims
  def index
    @claims = Claim.all

    render json: @claims
  end

  # GET /claims/1
  def show
    render json: @claim
  end

  # POST /claims
  def create
    @claim = Claim.new(claim_params)

    if @claim.save
      render json: @claim, status: :created, location: @claim
    else
      render json: @claim.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /claims/1
  def update
    if @claim.update(claim_params)
      render json: @claim
    else
      render json: @claim.errors, status: :unprocessable_entity
    end
  end

  # DELETE /claims/1
  def destroy
    @claim.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def claim_params
      params.fetch(:claim, {})
    end
end
