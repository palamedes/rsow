class Valuation < ApplicationRecord

  # Relationships
  belongs_to :company

  # validations
  validates :datetime, :open, :high, :low, :close, :volume, presence: true

  # Dump to json just what we need
  def as_json(*)
    super.except('id', 'company_id', 'datetime', 'created_at', 'updated_at').tap do |hash|
      hash['date'] = datetime
    end
  end

end
