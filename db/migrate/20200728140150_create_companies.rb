class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|

      t.string :symbol,       null: false, index: true
      t.string :asset_type,   null: false, default: 'Common Stock'
      t.string :name,         null: false
      t.text :description,    null: false
      t.string :exchange,     null: false, default: 'NYSE'
      t.string :currency,     null: false, default: 'USD'
      t.string :country,      null: false, default: 'USA'
      t.string :Sector
      t.string :Industry
      t.string :Address
      t.string :FullTimeEmployees
      t.string :FiscalYearEnd
      t.string :LatestQuarter
      t.float :MarketCapitalization
      t.float :EBITDA
      t.float :PERatio
      t.float :PEGRatio
      t.float :BookValue
      t.float :DividendPerShare
      t.float :DividendYield
      t.float :EPS
      t.float :RevenuePerShareTTM
      t.float :ProfitMargin
      t.float :OperatingMarginTTM
      t.float :ReturnOnAssetsTTM
      t.float :ReturnOnEquityTTM
      t.float :RevenueTTM
      t.float :GrossProfitTTM
      t.float :DilutedEPSTTM
      t.float :QuarterlyEarningsGrowthYOY
      t.float :QuarterlyRevenueGrowthYOY
      t.float :AnalystTargetPrice
      t.float :TrailingPE
      t.float :ForwardPE
      t.float :PriceToSalesRatioTTM
      t.float :PriceToBookRatio
      t.float :EVToRevenue
      t.float :EVToEBITDA
      t.float :Beta
      t.float :WeekHigh52
      t.float :WeekLow52
      t.float :DayMovingAverage52
      t.float :DayMovingAverage200
      t.float :SharesOutstanding
      t.float :SharesFloat
      t.float :SharesShort
      t.float :SharesShortPriorMonth
      t.float :ShortRatio
      t.float :ShortPercentOutstanding
      t.float :ShortPercentFloat
      t.float :PercentInsiders
      t.float :PercentInstitutions
      t.float :ForwardAnnualDividendRate
      t.float :ForwardAnnualDividendYield
      t.float :PayoutRatio
      t.float :DividendDate
      t.float :ExDividendDate
      t.string :LastSplitFactor
      t.float :LastSplitDate

      t.timestamps
    end
  end
end
