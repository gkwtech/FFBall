class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :position
      t.string :gsis_id, null: false
      t.integer :height
      t.integer :weight
      t.integer :years_pro

      t.timestamps null: false
    end
  end
end
