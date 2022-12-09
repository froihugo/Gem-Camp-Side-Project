class Api::CitiesController < ApplicationController
  def index
    city = Address::Cities.all
    render json: city, each_serializer: CitySerializer
  end
end
