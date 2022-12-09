class Api::ProvincesController < ApplicationController
  def index
    province = Address::Provinces.all
    render json: province, each_serializer: ProvinceSerializer
  end
end