class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :style, default: "auction", null: false

      t.timestamps null: false
    end
  end
end
