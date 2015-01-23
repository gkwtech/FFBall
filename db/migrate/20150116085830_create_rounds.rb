class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :number, null: false
      t.time :length
      t.integer :draft_id, null: false

      t.timestamps null: false
    end
  end
end
