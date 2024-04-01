# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[show update destroy quotation_show]

  # GET /invoices
  def index
    if params[:society_id]
      invoices = current_user.invoices.includes(:client)
                             .where(society_id: params[:society_id])
    end
    invoices = invoices.where(category: params[:category]) if params[:category]
    render json: invoices&.as_json(
      include: { client: { only: %i[first_name last_name business_name is_pro] } }
    )
  end

  # GET /invoices/1
  def show
    if @invoice.category == 'invoice'
      render json: { invoice: @invoice, author: @invoice.society, client: @invoice.client }
    else
      render json: { error: 'Not an invoice' }, status: :not_found
    end
  end

  def quotation_show
    if @invoice.category == 'quotation'
      render json: { invoice: @invoice, author: @invoice.society, client: @invoice.client }
    else
      render json: { error: 'Not a quotation' }, status: :not_found
    end
  end

  # POST /invoices
  def create
    user = current_user
    user_societies = user.societies
    society = user_societies.find(invoice_params[:society_id]) || user_societies.first
    client = get_or_create_client(invoice_params)
    invoice = Invoice.new(invoice_params.except(:client_infos, :society_infos).merge(society:, user:, client:))

    if invoice.save
      render json: invoice, status: :created, location: invoice
    else
      render json: invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    invoice = @invoice
    client_infos = invoice_params[:client_infos]
    society_infos = invoice_params[:society_infos]

    invoice.client.update!(client_infos) if client_infos

    invoice.society.update!(society_infos) if society_infos

    if invoice.update(invoice_params.except(:client_infos, :society_infos))
      render json: invoice
    else
      render json: invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy!
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @invoice.user_id == current_user.id
  end

  def get_or_create_client(invoice_params)
    if invoice_params[:client_id]
      current_user.clients.find(invoice_params[:client_id])
    else
      Client.create!(invoice_params[:client_infos].merge(
                       user_id: current_user.id, society_id: @invoice.society.id
                     ))
    end
  end

  def invoice_params
    params.require(:invoice).permit(
      :content, :issued_at, :due_at, :title, :subtotal, :tva, :total, :sale, :is_draft,
      :is_paid, :status, :number, :additional_info, :client_id, :society_id,
      society_infos: %i[name address zip city country siret status capital email],
      client_infos: %i[business_name first_name last_name address zip city is_pro siret email country]
    )
  end
end
