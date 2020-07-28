class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|

      t.string :symbol,       null: false, index: true
      t.string :assettype,   null: false, default: 'common stock'
      t.string :name,         null: false
      t.text :description,    null: false
      t.string :exchange,     null: false, default: 'nyse'
      t.string :currency,     null: false, default: 'usd'
      t.string :country,      null: false, default: 'usa'
      t.string :sector
      t.string :industry
      t.string :address
      t.string :fulltimeemployees
      t.string :fiscalyearend
      t.string :latestquarter
      t.float :marketcapitalization
      t.float :ebitda
      t.float :peratio
      t.float :pegratio
      t.float :bookvalue
      t.float :dividendpershare
      t.float :dividendyield
      t.float :eps
      t.float :revenuepersharettm
      t.float :profitmargin
      t.float :operatingmarginttm
      t.float :returnonassetsttm
      t.float :returnonequityttm
      t.float :revenuettm
      t.float :grossprofitttm
      t.float :dilutedepsttm
      t.float :quarterlyearningsgrowthyoy
      t.float :quarterlyrevenuegrowthyoy
      t.float :analysttargetprice
      t.float :trailingpe
      t.float :forwardpe
      t.float :pricetosalesratiottm
      t.float :pricetobookratio
      t.float :evtorevenue
      t.float :evtoebitda
      t.float :beta
      t.float :weekhigh52
      t.float :weeklow52
      t.float :daymovingaverage52
      t.float :daymovingaverage200
      t.float :sharesoutstanding
      t.float :sharesfloat
      t.float :sharesshort
      t.float :sharesshortpriormonth
      t.float :shortratio
      t.float :shortpercentoutstanding
      t.float :shortpercentfloat
      t.float :percentinsiders
      t.float :percentinstitutions
      t.float :forwardannualdividendrate
      t.float :forwardannualdividendyield
      t.float :payoutratio
      t.float :dividenddate
      t.float :exdividenddate
      t.string :lastsplitfactor
      t.float :lastsplitdate

      t.timestamps
    end
  end
end
