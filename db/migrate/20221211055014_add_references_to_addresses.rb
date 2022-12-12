class AddReferencesToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :address_region
    add_reference :addresses, :address_province
    add_reference :addresses, :address_city
    add_reference :addresses, :address_barangay
  end
end
