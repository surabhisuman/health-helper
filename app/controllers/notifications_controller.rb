class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show update destroy approve_notification]

  # GET /notifications?person_id
  def index
    if params[:person_id].present?
      @notifications = Notification.where(person_id: params[:person_id])
    else
      @notifications = Notification.all
    end

    render json: @notifications
  end

  # GET /notifications/1
  def show
    render json: @notification
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: @notification, status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
  end

  def approve_notification
    notification_id = params[:id]
    approval = params[:approval] # boolean (true/false)
    consultation = @notification.consultation
    Consent.create(consultation_id: consultation.id, person_id: @notification.person_id, registered_on: Time.now)
    if approval
      @notification.update(notification_type: Notification::TYPE["NOTICE"], data: @notification.data + " Approved")
    else
      @notification.update(notification_type: Notification::TYPE["NOTICE"], data: @notification.data + " Rejected")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.fetch(:notification, {})
    end
end
