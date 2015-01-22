class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :number, null: false
      t.integer :price, null: false

      t.timestamps null: false
    end
  end
end
