class CreateAddresses < ActiveRecord::Migration[7.0]
    def change
      create_table :addresses do |t|
        t.string :name
        t.string :phone_number
        t.text :remark
        t.string :street_address
        t.boolean :is_default, default: false
        t.integer :genre, default: 0, null: false
        t.references :user
        t.timestamps null: false
    end
  end
end
