require "test_helper"

class HealthReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @health_report = health_reports(:one)
  end

  test "should get index" do
    get health_reports_url, as: :json
    assert_response :success
  end

  test "should create health_report" do
    assert_difference("HealthReport.count") do
      post health_reports_url, params: { health_report: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show health_report" do
    get health_report_url(@health_report), as: :json
    assert_response :success
  end

  test "should update health_report" do
    patch health_report_url(@health_report), params: { health_report: {  } }, as: :json
    assert_response :success
  end

  test "should destroy health_report" do
    assert_difference("HealthReport.count", -1) do
      delete health_report_url(@health_report), as: :json
    end

    assert_response :no_content
  end
end
