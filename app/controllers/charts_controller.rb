class ChartsController < ApplicationController
  before_action :authenticate_user!

  def sum_all_client
    @sum_all_client = Invoice.includes(:client)
                            .where(user_id: current_user)
                            .group('clients.business_name')
                            .order('clients.business_name')
                            .sum('total')
    render json: @sum_all_client
  end
  

  def sum_all_society
    @sum_all_society = Invoice.includes(:society)
                              .where(user_id: current_user)
                              .group('societies.name')
                              .order('societies.name')
                              .sum("total")
    render json: @sum_all_society
  end

  def transformed
    @transformed = Invoice.where(user_id: current_user, category: 'invoice').count
    render json: @transformed
  end

  def notransformed
    @notransformed = Invoice.where(user_id: current_user, category: 'quotation').count
    render json: @notransformed
  end

  def invoice_paid
    @invoice_paid = Invoice.includes(:client)
                            .where(user_id: current_user, is_paid: true)
                            .pluck('clients.business_name', :total)
    render json: @invoice_paid
  end

  def invoice_not_paid
    @invoice_not_paid = Invoice.includes(:client)
                            .where(user_id: current_user, is_paid: false)
                            .pluck('clients.business_name', :total)
    render json: @invoice_not_paid
  end




  def sum_all_client_by_society
    @sum_all_client_by_society = Invoice.includes(:client)
                                        .where(user_id: current_user.id, society_id: params[:society_id])
                                        .group('business_name')
                                        .sum(:total)
    render json: @sum_all_client_by_society
  end

  def sum_all_sub_total_by_client_by_society
    @sum_all_sub_total_by_client_by_society = Invoice.includes(:client)
                                              .where(user_id: current_user.id, society_id: params[:society_id])
                                              .group('business_name')
                                              .sum(:subtotal) 
    render json:@sum_all_sub_total_by_client_by_society
  end

  def sum_all_tva_by_client_by_society
    @sum_all_tva_by_client_by_society = Invoice.includes(:client)
                                              .where(user_id: current_user.id, society_id: params[:society_id])
                                              .group('business_name')
                                              .sum(:tva) 
    render json:@sum_all_tva_by_client_by_society
  end



  def sum_by_country_ordered_alphabet
    @sum_by_country_ordered_alphabet = Client.where(user_id: current_user.id)
                                            .joins(:invoices)
                                            .group(:country, 'clients.id')
                                            .pluck('clients.id', :country, 'SUM(invoices.total)')
    render json: @sum_by_country_ordered_alphabet
  end

  # def number_invoice_by_country
  #   @number_invoice_by_country= Invoice.where(user_id: current_user.id)
  #                                     .includes(:society)
  #                                     .group(:country)
                                      
  # end

end




  # faire somme des factures d'un user: Invoice.where(user_id: 1).sum("total")
  # faire somme des factures d'un client: Invoice.where(client_id: 1).sum(:total)
  # nombre de produit vendus par client: 