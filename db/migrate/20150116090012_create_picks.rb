class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :number
      t.integer :price

      t.timestamps null: false
    end
  end
end
