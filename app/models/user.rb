class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :parent, class_name: 'User', optional: true, counter_cache: :children_members
  has_many :children_members, class_name: "User", foreign_key: 'parent_id'

  has_many :addresses

  mount_uploader :avatar, AvatarUploader

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, :with => /^[A-Za-z\d ]*$/, :multiline => true

  validates :phone, phone: { uniqueness: true, allow_blank: true, countries: [:ph] }

  enum role: { client: 0, admin: 1 }

  def to_param
    username
  end

end
