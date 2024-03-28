# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[show update destroy]

  # GET /clients
  def index
    @clients = if params[:society_id]
                 current_user.societies.find(params[:society_id]).clients
               else
                 current_user.societies.first.clients
               end
    render json: @clients, include: :invoices
  end

  # GET /clients/1
  def show
    render json: @client, include: :invoices
  end

  # POST /clients
  def create
    @client = Client.new(client_params.except(:user_id, :society_id))
    @client.user = current_user
    @client.society = current_user.societies.find(params[:client][:society_id])

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params.except(:user_id, :society_id))
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
    return unless current_user.id != @client.user_id

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:first_name, :last_name, :address, :zip, :city, :siret, :is_pro, :user_id,
                                   :society_id, :business_name, :email, :country)
  end
end
