class BarangaySerializer < ActiveModel::Serializer
  attributes :name, :city, :id

  def city
    object.city.name
  end
end