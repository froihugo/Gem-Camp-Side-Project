class Address < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :phone_number, presence: true
    validates :street_address, presence: true
    validates :name, presence: true
    validates :phone_number, phone: { uniqueness: true, allow_blank: true, countries: [:ph] }

    enum genre: { home: 0, office: 1 }
end
