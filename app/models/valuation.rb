class Valuation < ApplicationRecord

  # Relationships
  belongs_to :company

  # validations
  validates :datetime, :open, :high, :low, :close, :volume, presence: true

end
