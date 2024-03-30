# frozen_string_literal: true

class RegistersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_register, only: %i[show update destroy]

  # GET /registers
  def index
    @registers = filter_by_month_and_year(current_user.registers.order(paid_at: :desc))
    @registers = @registers.where(society_id: params[:society_id]) if params[:society_id]
    render json: @registers
  end

  # GET /registers/1
  def show
    render json: @register
  end

  # POST /registers
  def create
    user = current_user
    society = user.societies.find_by(id: register_params[:society_id]) || user.societies.first
    @register = Register.new(register_params.except(:user_id, :society_id).merge(society:))

    if @register.save
      render json: @register, status: :created, location: @register
    else
      render json: @register.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /registers/1
  def update
    if @register.update(register_params.except(:user_id, :society_id))
      render json: @register
    else
      render json: @register.errors, status: :unprocessable_entity
    end
  end

  # DELETE /registers/1
  def destroy
    @register.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_register
    @register = Register.find(params[:id])

    return unless @register.user != current_user

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  # Only allow a list of trusted parameters through.
  def register_params
    params.require(:register).permit(:paid_at, :society_id, :amount, :title, :comment, :payment_method, :is_income)
  end

  def filter_by_month_and_year(registers)
    return registers unless (year = params[:year]) && (month = params[:month])

    beginning_of_month = Date.new(year.to_i, month.to_i, 1)
    end_of_month = beginning_of_month.end_of_month
    registers.where(paid_at: beginning_of_month..end_of_month)
  end
end
