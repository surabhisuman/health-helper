require "test_helper"

class ClaimStatusHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim_status_history = claim_status_histories(:one)
  end

  test "should get index" do
    get claim_status_histories_url, as: :json
    assert_response :success
  end

  test "should create claim_status_history" do
    assert_difference("ClaimStatusHistory.count") do
      post claim_status_histories_url, params: { claim_status_history: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show claim_status_history" do
    get claim_status_history_url(@claim_status_history), as: :json
    assert_response :success
  end

  test "should update claim_status_history" do
    patch claim_status_history_url(@claim_status_history), params: { claim_status_history: {  } }, as: :json
    assert_response :success
  end

  test "should destroy claim_status_history" do
    assert_difference("ClaimStatusHistory.count", -1) do
      delete claim_status_history_url(@claim_status_history), as: :json
    end

    assert_response :no_content
  end
end
