class ClaimStatusHistoriesController < ApplicationController
  before_action :set_claim_status_history, only: %i[ show update destroy ]

  # GET /claim_status_histories
  def index
    @claim_status_histories = ClaimStatusHistory.all

    render json: @claim_status_histories
  end

  # GET /claim_status_histories/1
  def show
    render json: @claim_status_history
  end

  # POST /claim_status_histories
  def create
    @claim_status_history = ClaimStatusHistory.new(claim_status_history_params)

    if @claim_status_history.save
      render json: @claim_status_history, status: :created, location: @claim_status_history
    else
      render json: @claim_status_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /claim_status_histories/1
  def update
    if @claim_status_history.update(claim_status_history_params)
      render json: @claim_status_history
    else
      render json: @claim_status_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /claim_status_histories/1
  def destroy
    @claim_status_history.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_status_history
      @claim_status_history = ClaimStatusHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def claim_status_history_params
      params.fetch(:claim_status_history, {})
    end
end
