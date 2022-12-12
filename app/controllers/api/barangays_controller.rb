class Api::BarangaysController < ApplicationController
  def index
    cities = Address::City.find(params[:city_id])
    barangays = cities.barangays
    render json: barangays, each_serializer: BarangaySerializer
  end
end
