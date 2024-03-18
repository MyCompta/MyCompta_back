require "test_helper"

class SocietiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @society = societies(:one)
  end

  test "should get index" do
    get societies_url, as: :json
    assert_response :success
  end

  test "should create society" do
    assert_difference("Society.count") do
      post societies_url, params: { society: { adress: @society.adress, capital: @society.capital, city: @society.city, country: @society.country, email: @society.email, name: @society.name, siret: @society.siret, status: @society.status, zip: @society.zip } }, as: :json
    end

    assert_response :created
  end

  test "should show society" do
    get society_url(@society), as: :json
    assert_response :success
  end

  test "should update society" do
    patch society_url(@society), params: { society: { adress: @society.adress, capital: @society.capital, city: @society.city, country: @society.country, email: @society.email, name: @society.name, siret: @society.siret, status: @society.status, zip: @society.zip } }, as: :json
    assert_response :success
  end

  test "should destroy society" do
    assert_difference("Society.count", -1) do
      delete society_url(@society), as: :json
    end

    assert_response :no_content
  end
end
