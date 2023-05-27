require "test_helper"

class ConsentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consent = consents(:one)
  end

  test "should get index" do
    get consents_url, as: :json
    assert_response :success
  end

  test "should create consent" do
    assert_difference("Consent.count") do
      post consents_url, params: { consent: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show consent" do
    get consent_url(@consent), as: :json
    assert_response :success
  end

  test "should update consent" do
    patch consent_url(@consent), params: { consent: {  } }, as: :json
    assert_response :success
  end

  test "should destroy consent" do
    assert_difference("Consent.count", -1) do
      delete consent_url(@consent), as: :json
    end

    assert_response :no_content
  end
end
