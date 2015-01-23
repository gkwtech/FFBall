class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name, null: false
      t.string :password
      t.integer :max_players, default: 13, null: false

      t.timestamps null: false
    end
  end
end
