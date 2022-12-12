class AddColumnToAddressRegion < ActiveRecord::Migration[7.0]
  def change
    add_column :address_regions, :region_name, :string
  end
end
