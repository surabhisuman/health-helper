require "test_helper"

class ClaimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim = claims(:one)
  end

  test "should get index" do
    get claims_url, as: :json
    assert_response :success
  end

  test "should create claim" do
    assert_difference("Claim.count") do
      post claims_url, params: { claim: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show claim" do
    get claim_url(@claim), as: :json
    assert_response :success
  end

  test "should update claim" do
    patch claim_url(@claim), params: { claim: {  } }, as: :json
    assert_response :success
  end

  test "should destroy claim" do
    assert_difference("Claim.count", -1) do
      delete claim_url(@claim), as: :json
    end

    assert_response :no_content
  end
end
