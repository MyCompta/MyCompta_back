# frozen_string_literal: true

class RegistersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_register, only: %i[show update destroy]

  # GET /registers
  def index
    @registers = if params[:society_id]
                   current_user.registers
                               .where(society_id: params[:society_id])
                 else
                   current_user.registers
                 end

    render json: @registers
  end

  # GET /registers/1
  def show
    render json: @register
  end

  # POST /registers
  def create
    user = current_user
    society = user.societies.find(register_params[:society_id])
    @register = Register.new(register_params.except(:user_id, :society_id).merge(user:, society:))

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
end
