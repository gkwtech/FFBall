class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.integer :player_id, null: false
      t.integer :team_id, null: false
      t.string :status, null: false
      t.string :position

      t.timestamps null: false
    end
  end
end
