class CreateValuations < ActiveRecord::Migration[6.0]
  def change
    create_table :valuations do |t|

      t.references :company,    null: false

      t.datetime :datetime,     null: false

      t.string :data_type,      null: false, default: :quote
      t.float :price

      t.float :open,            null: false
      t.float :high,            null: false
      t.float :low,             null: false
      t.float :close,           null: false
      t.float :volume,          null: false
      t.float :change
      t.float :change_percent

      t.timestamps
    end
  end
end
