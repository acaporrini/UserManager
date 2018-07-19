class UserProperty < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :name, presence: true
  validates :value, presence: true
end
