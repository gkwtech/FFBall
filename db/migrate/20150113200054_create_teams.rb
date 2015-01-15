class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :league_id, null: false
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.integer :ties

      t.timestamps null: false
    end
  end
end
