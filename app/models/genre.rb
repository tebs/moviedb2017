class Genre < ApplicationRecord

  # equivalent to:
  # validates_presence_of :name
  # validates_uniqueness_of :name
  validates :name,
    presence: true,
    uniqueness: true

  has_many :movies
end
