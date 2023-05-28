class ConsentsController < ApplicationController
  before_action :set_consent, only: %i[ show update destroy ]

  # GET /consents
  def index
    @consents = Consent.all

    render json: @consents
  end

  # GET /consents/1
  def show
    render json: @consent
  end

  def approve_consent
    @consent = Consent.create(consultation_id: params[:consultation_id], person_id: params[:person_id], registered_on: Time.now)
    notification = Notification.find_by(id: params[:notification_id])
    notification.update(notification_type: Notification::TYPE["NOTICE"], data: @notification.data + " Approved")
    render json: @consent
  end

  # POST /consents
  def create
    @consent = Consent.new(consent_params)

    if @consent.save
      render json: @consent, status: :created, location: @consent
    else
      render json: @consent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /consents/1
  def update
    if @consent.update(consent_params)
      render json: @consent
    else
      render json: @consent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /consents/1
  def destroy
    @consent.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consent
      @consent = Consent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consent_params
      params.fetch(:consent)
    end
end
