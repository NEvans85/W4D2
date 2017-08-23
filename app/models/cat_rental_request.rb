class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def overlapping_requests
    cat.rental_requests.where("(start_date - :end_date) * (:start_date - end_date) >= 0 AND id != :id",
                    {start_date: self.start_date, end_date: self.end_date, id: self.id} )
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == "APPROVED" }
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.empty?
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"

      unless self.save
        deny!
      end
    end
  end

  def deny!
    CatRentalRequest.transaction do
      self.status = "DENIED"
      self.save
    end
  end

  def pending?
    self.status == "PENDING"
  end
end
