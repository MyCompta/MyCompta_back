class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[ show update destroy ]

  # GET /invoices
  def index
    if params[:society_id]
        @invoices = Invoice.where(society_id: params[:society_id])
      else
        @invoices = Invoice.all
      end

    render json: @invoices
  end

  # GET /invoices/1
  def show
    render json: { invoice: @invoice, author: @invoice.society }
  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user

    if invoice_params.include?(:society_id)
      @invoice.society = current_user.societies.find(invoice_params[:society_id])

      if @invoice.society.nil?
        return render json: { error: 'Society not found' }, status: :not_found
      end
    else
      @invoice.society = current_user.societies.first
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
    if @invoice.update(invoice_params)
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
      params.require(:invoice).permit(:content, :date, :due_date, :title, :subtotal, :tva, :total, :sale, :is_draft, :is_paid, :status, :number, :society_id)
    end
end
