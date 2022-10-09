class Tag < ApplicationRecord
  has_many :position, dependent: :destroy
  has_many :users, through: :position, dependent: :destroy
end
