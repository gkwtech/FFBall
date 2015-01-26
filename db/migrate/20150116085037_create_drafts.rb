class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.integer :year
      t.string :name

      t.timestamps null: false
    end
  end
end
