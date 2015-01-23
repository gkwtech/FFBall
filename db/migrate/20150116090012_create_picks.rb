class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :number, null: false
      t.integer :price, null: false
      t.integer :round_id, null: false
      t.integer :player_id, null: false
      t.integer :team_id, null: false

      t.timestamps null: false
    end
  end
end
