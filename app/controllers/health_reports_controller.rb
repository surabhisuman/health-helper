class HealthReportsController < ApplicationController
  before_action :set_health_report, only: %i[ show update destroy ]

  # GET /health_reports
  def index
    @health_reports = HealthReport.all

    render json: @health_reports
  end

  # GET /health_reports/1
  def show
    render json: @health_report
  end

  # POST /health_reports
  def create
    @health_report = HealthReport.new(health_report_params)

    if @health_report.save
      render json: @health_report, status: :created, location: @health_report
    else
      render json: @health_report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /health_reports/1
  def update
    if @health_report.update(health_report_params)
      render json: @health_report
    else
      render json: @health_report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /health_reports/1
  def destroy
    @health_report.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_report
      @health_report = HealthReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def health_report_params
      params.fetch(:health_report, {})
    end
end
