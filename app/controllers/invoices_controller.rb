class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[ show update destroy quotation_show ]

  # GET /invoices
  def index
    if params[:society_id]
      @invoices = current_user.invoices.includes(:client).where(society_id: params[:society_id])
      @invoices = @invoices.where(category: params[:category]) if params[:category]
    else
      @invoices = current_user.invoices.includes(:client)
    end
  
    render json: @invoices.as_json(include: { client: { only: [:first_name, :last_name, :business_name, :is_pro] } })
  end

  # GET /invoices/1
  def show
    if @invoice.category == "invoice"
      render json: { invoice: @invoice, author: @invoice.society, client: @invoice.client }
    else
      render json: { error: "Not an invoice" }, status: :not_found
    end
  end

  def quotation_show
    if @invoice.category == "quotation"
      render json: { invoice: @invoice, author: @invoice.society, client: @invoice.client }
    else 
      render json: { error: "Not a quotation" }, status: :not_found
    end
  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params.except(:client_infos, :society_infos))
    @invoice.user = current_user

    if invoice_params.include?(:society_id)
      @invoice.society = current_user.societies.find(invoice_params[:society_id])

      if @invoice.society.nil?
        return render json: { error: 'Society not found' }, status: :not_found
      end
    else
      @invoice.society = current_user.societies.first
    end

    if invoice_params.include?(:client_id)
      @invoice.client = current_user.clients.find(invoice_params[:client_id])
    else
      @client = Client.create!(invoice_params[:client_infos].merge(user_id: current_user.id, society_id: @invoice.society.id))
      @invoice.client = @client
    end

    # Invoice.create!(invoice_params.merge(user_id: current_user.id))

    if @invoice.save
      render json: @invoice, status: :created, location: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    if invoice_params.include?(:client_infos)
      @invoice.client.update!(invoice_params[:client_infos])
    end

    if invoice_params.include?(:society_infos)
      @invoice.society.update!(invoice_params[:society_infos])
    end

    if @invoice.update(invoice_params.except(:client_infos, :society_infos))
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])

      if @invoice.user_id != current_user.id
        return render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:category, :content, :issued_at, :due_at, :title, :subtotal, :tva, :total, :sale, :is_draft, :is_paid, :status, :number, :additional_info, :client_id, :society_id, society_infos: [:name, :adress, :zip, :city, :country, :siret, :status, :capital, :email], client_infos: [:business_name, :first_name, :last_name, :address, :zip, :city, :is_pro, :siret, :email, :country])
    end
end
