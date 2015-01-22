class AddCommissionerIdToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :commissioner_id, :integer, null: false
  end
end
