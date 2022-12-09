class AddressCity < ActiveRecord::Migration[7.0]
  def change
    create_table :address_cities do |t|
      t.string :code
      t.string :name
      t.references :province
      t.timestamps
    end
  end
end
