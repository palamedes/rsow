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

  # Dump data we need as a csv
  def as_csv
    [ datetime.to_s, low, open, close, high ]
  end

end
