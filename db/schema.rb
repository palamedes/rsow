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
    t.string "assettype", default: "common stock", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.string "exchange", default: "nyse", null: false
    t.string "currency", default: "usd", null: false
    t.string "country", default: "usa", null: false
    t.string "sector"
    t.string "industry"
    t.string "address"
    t.string "fulltimeemployees"
    t.string "fiscalyearend"
    t.string "latestquarter"
    t.float "marketcapitalization"
    t.float "ebitda"
    t.float "peratio"
    t.float "pegratio"
    t.float "bookvalue"
    t.float "dividendpershare"
    t.float "dividendyield"
    t.float "eps"
    t.float "revenuepersharettm"
    t.float "profitmargin"
    t.float "operatingmarginttm"
    t.float "returnonassetsttm"
    t.float "returnonequityttm"
    t.float "revenuettm"
    t.float "grossprofitttm"
    t.float "dilutedepsttm"
    t.float "quarterlyearningsgrowthyoy"
    t.float "quarterlyrevenuegrowthyoy"
    t.float "analysttargetprice"
    t.float "trailingpe"
    t.float "forwardpe"
    t.float "pricetosalesratiottm"
    t.float "pricetobookratio"
    t.float "evtorevenue"
    t.float "evtoebitda"
    t.float "beta"
    t.float "weekhigh52"
    t.float "weeklow52"
    t.float "daymovingaverage52"
    t.float "daymovingaverage200"
    t.float "sharesoutstanding"
    t.float "sharesfloat"
    t.float "sharesshort"
    t.float "sharesshortpriormonth"
    t.float "shortratio"
    t.float "shortpercentoutstanding"
    t.float "shortpercentfloat"
    t.float "percentinsiders"
    t.float "percentinstitutions"
    t.float "forwardannualdividendrate"
    t.float "forwardannualdividendyield"
    t.float "payoutratio"
    t.float "dividenddate"
    t.float "exdividenddate"
    t.string "lastsplitfactor"
    t.float "lastsplitdate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["symbol"], name: "index_companies_on_symbol"
  end

end
