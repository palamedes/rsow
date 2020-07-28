# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_28_140150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "asset_type", default: "Common Stock", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.string "exchange", default: "NYSE", null: false
    t.string "currency", default: "USD", null: false
    t.string "country", default: "USA", null: false
    t.string "Sector"
    t.string "Industry"
    t.string "Address"
    t.string "FullTimeEmployees"
    t.string "FiscalYearEnd"
    t.string "LatestQuarter"
    t.float "MarketCapitalization"
    t.float "EBITDA"
    t.float "PERatio"
    t.float "PEGRatio"
    t.float "BookValue"
    t.float "DividendPerShare"
    t.float "DividendYield"
    t.float "EPS"
    t.float "RevenuePerShareTTM"
    t.float "ProfitMargin"
    t.float "OperatingMarginTTM"
    t.float "ReturnOnAssetsTTM"
    t.float "ReturnOnEquityTTM"
    t.float "RevenueTTM"
    t.float "GrossProfitTTM"
    t.float "DilutedEPSTTM"
    t.float "QuarterlyEarningsGrowthYOY"
    t.float "QuarterlyRevenueGrowthYOY"
    t.float "AnalystTargetPrice"
    t.float "TrailingPE"
    t.float "ForwardPE"
    t.float "PriceToSalesRatioTTM"
    t.float "PriceToBookRatio"
    t.float "EVToRevenue"
    t.float "EVToEBITDA"
    t.float "Beta"
    t.float "WeekHigh52"
    t.float "WeekLow52"
    t.float "DayMovingAverage52"
    t.float "DayMovingAverage200"
    t.float "SharesOutstanding"
    t.float "SharesFloat"
    t.float "SharesShort"
    t.float "SharesShortPriorMonth"
    t.float "ShortRatio"
    t.float "ShortPercentOutstanding"
    t.float "ShortPercentFloat"
    t.float "PercentInsiders"
    t.float "PercentInstitutions"
    t.float "ForwardAnnualDividendRate"
    t.float "ForwardAnnualDividendYield"
    t.float "PayoutRatio"
    t.float "DividendDate"
    t.float "ExDividendDate"
    t.string "LastSplitFactor"
    t.float "LastSplitDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["symbol"], name: "index_companies_on_symbol"
  end

end
