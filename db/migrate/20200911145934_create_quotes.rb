class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|

      t.references :company,    null: false

      t.datetime :datetime,     null: false

      t.float :high,            null: false
      t.float :low,             null: false
      t.float :open,            null: false
      t.float :close,           null: false

      t.string :scale,          null: false, default: 'DAILY'

      t.timestamps
    end
  end
end
