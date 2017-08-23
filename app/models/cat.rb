class Cat < ApplicationRecord
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: %w(black grey orange calico white other) }
  validates :sex, inclusion: { in: %w(M F) }

  include ActionView::Helpers::DateHelper

  has_many :rental_requests,
           foreign_key: :cat_id,
           class_name: :CatRentalRequest,
           dependent: :destroy

  def age
    time_ago_in_words(self.birth_date)
  end
end
