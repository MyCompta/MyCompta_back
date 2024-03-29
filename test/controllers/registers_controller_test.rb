# frozen_string_literal: true

require 'test_helper'

class RegistersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @register = registers(:one)
  end

  test 'should get index' do
    get registers_url, as: :json
    assert_response :success
  end

  test 'should create register' do
    assert_difference('Register.count') do
      post registers_url, params: {
        register: {
          amount: @register.amount,
          comment: @register.comment,
          is_income: @register.is_income,
          paid_at: @register.paid_at,
          payment_method: @register.payment_method,
          society_id: @register.society_id,
          title: @register.title,
          user_id: @register.user_id
        }
      }, as: :json
    end

    assert_response :created
  end

  test 'should show register' do
    get register_url(@register), as: :json
    assert_response :success
  end

  test 'should update register' do
    patch register_url(@register), params: {
      register: {
        amount: @register.amount,
        comment: @register.comment,
        is_income: @register.is_income,
        paid_at: @register.paid_at,
        payment_method: @register.payment_method,
        society_id: @register.society_id,
        title: @register.title,
        user_id: @register.user_id
      }
    }, as: :json
    assert_response :success
  end

  test 'should destroy register' do
    assert_difference('Register.count', -1) do
      delete register_url(@register), as: :json
    end

    assert_response :no_content
  end
end
