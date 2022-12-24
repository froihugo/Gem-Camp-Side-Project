class Item < ApplicationRecord

    default_scope { where(deleted_at: nil) }

    def destroy
      update(deleted_at: Time.current)
    end

    mount_uploader :image, ImageUploader

    validates :name, presence: true
    validates :minimum_bets, presence: true
    validates :online_at, presence: true
    validates :offline_at, presence: true
    validates :start_at, presence: true
    validates :status, presence: true

    enum status: { Inactive: 0, Active: 1 }
  end