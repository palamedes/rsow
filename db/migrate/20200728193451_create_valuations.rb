class CreateValuations < ActiveRecord::Migration[6.0]
  def change
    create_table :valuations do |t|

      t.references :company, null: false

      t.datetime :datetime, null: false

      t.float :open, null: false
      t.float :high, null: false
      t.float :low,  null: false
      t.float :close, null: false
      t.float :volume, null: false

      t.timestamps
    end
  end
end
