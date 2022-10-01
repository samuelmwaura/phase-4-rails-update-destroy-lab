class PlantsController < ApplicationController

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_a_plant
    render json: plant
  rescue ActiveRecord::RecordNotFound
    send_error
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  #PATCH /plants/:id
  def update
    plant = find_a_plant
    plant.update(plant_params)
    render json: plant,status: :accepted
    rescue ActiveRecord::RecordNotFound
    send_error
  end

#DESTROY /plants/:id
   def destroy
      plant = find_a_plant
      plant.destroy
      head :no_content
      rescue ActiveRecord::RecordNotFound
      send_error
   end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_a_plant
    plant = Plant.find(params[:id])
  end

  def send_error
    render json: {error:"Plant Not Found!"},status: :not_found
  end
end
