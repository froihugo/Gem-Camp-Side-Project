class Api::BarangaysController < ApplicationController
  def index
    barangay = Address::Barangays.all
    render json: barangay, each_serializer: BarangaySerializer
  end
end
