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
    render json: @society
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
    if @society.update(society_params)
      render json: @society
    else
      render json: @society.errors, status: :unprocessable_entity
    end
  end

  # DELETE /societies/1
  def destroy
    @society.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_society
      @society = Society.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def society_params
      params.require(:society).permit(:name, :adress, :zip, :city, :country, :siret, :status, :capital, :email)
    end
end
