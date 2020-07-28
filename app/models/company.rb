class Company < ApplicationRecord

  # Validations
  validates :symbol, :asset_type, :name, :description, :exchange, :currency, :country, presence: true

end
