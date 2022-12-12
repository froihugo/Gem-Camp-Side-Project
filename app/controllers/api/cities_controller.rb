class Api::CitiesController < ApplicationController
  def index
    province = Address::Province.find(params[:province_id])
    cities = province.cities
    render json: cities, each_serializer: CitySerializer
  end
end
