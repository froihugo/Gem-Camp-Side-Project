class Item < ApplicationRecord

    default_scope { where(deleted_at: nil) }

    def destroy
      update(deleted_at: Time.current)
    end

    has_many :item_category_ships, dependent: :restrict_with_error
    has_many :categories, through: :item_category_ships

    mount_uploader :image, ImageUploader

    validates :name, presence: true
    validates :minimum_bets, presence: true
    validates :online_at, presence: true
    validates :offline_at, presence: true
    validates :start_at, presence: true
    validates :status, presence: true

    enum status: { Inactive: 0, Active: 1 }
  end