class CreateRawquotes < ActiveRecord::Migration[6.0]
  def change
    create_table :rawquotes do |t|

      t.references :company,    null: false

      t.datetime :datetime,     null: false

      t.float :price,           null: false
      t.float :volume,          null: false

      t.timestamps
    end
  end
end
