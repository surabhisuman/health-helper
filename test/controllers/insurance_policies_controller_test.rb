require "test_helper"

class InsurancePoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @insurance_policy = insurance_policies(:one)
  end

  test "should get index" do
    get insurance_policies_url, as: :json
    assert_response :success
  end

  test "should create insurance_policy" do
    assert_difference("InsurancePolicy.count") do
      post insurance_policies_url, params: { insurance_policy: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show insurance_policy" do
    get insurance_policy_url(@insurance_policy), as: :json
    assert_response :success
  end

  test "should update insurance_policy" do
    patch insurance_policy_url(@insurance_policy), params: { insurance_policy: {  } }, as: :json
    assert_response :success
  end

  test "should destroy insurance_policy" do
    assert_difference("InsurancePolicy.count", -1) do
      delete insurance_policy_url(@insurance_policy), as: :json
    end

    assert_response :no_content
  end
end
