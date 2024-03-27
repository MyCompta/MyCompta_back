class SocietiesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_society, only: %i[ show update destroy ]

  # GET /societies
  def index
    @societies = current_user.societies

    render json: @societies
  end

  # GET /societies/1
  def show
    render json: @society
  end

  # POST /societies
  def create
    @society = Society.new(society_params.except(:user_id))
    @society.user = current_user

    if @society.save
      render json: @society, status: :created, location: @society
    else
      render json: @society.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /societies/1
  def update
    @society = Society.find(params[:id])

    if user_signed_in? && @society.user_id == current_user.id
      if @society.update(society_params)
        render json: @society
      else
        render json: @society.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
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

      if @society.user_id != current_user.id
        return render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end

    # Only allow a list of trusted parameters through.
    def society_params
      params.require(:society).permit(:name, :address, :zip, :city, :country, :siret, :status, :capital, :email, :user_id)
    end
end
