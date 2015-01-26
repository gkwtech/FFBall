class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :team_id, null: false
      t.string :week
      t.string :year

      t.timestamps null: false
    end
  end
end
