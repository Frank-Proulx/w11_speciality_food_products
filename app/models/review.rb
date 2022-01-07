class Review < ApplicationRecord
  belongs_to :product
  validates :author, presence: true
  validates :content_body, presence: true
  validates :rating, presence: true
  validates_length_of :content_body, minimum: 50
  validates_length_of :content_body, maximum: 250
  validates :rating, numericality: { only_integer: true }
  validates :rating, numericality: { greater_than_or_equal_to: 1 }
  validates :rating, numericality: { less_than_or_equal_to: 5 }
end