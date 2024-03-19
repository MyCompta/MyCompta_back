class SocietiesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_society, only: %i[ show update destroy ]

  # GET /societies
  def index
    @societies = Society.where(user: current_user)

    render json: @societies
  end

  # GET /societies/1
  def show
    @society = Society.find(params[:id])
    if user_signed_in? && @society.user_id == current_user.id
      render json: @society
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # POST /societies
  def create
    @society = Society.new(society_params)

    if @society.save
      render json: @society, status: :created, location: @society
    else
      render json: @society.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /societies/1
  def update
    if user_signed_in? && @society.user_id == current_user.id
    if @society.update(society_params)
      
      
        render json: @society
      end
    else
      render json: @society.errors, status: :unprocessable_entity
    end
  end

  # DELETE /societies/1
  def destroy
    if user_signed_in? && @society.user_id == current_user.id
      @society.destroy!
      render json: {message: 'destroy successful'}
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_society
      @society = Society.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def society_params
      params.require(:society).permit(:name, :adress, :zip, :city, :country, :siret, :status, :capital, :email, :user_id)
    end
end
