class AddLeagueIdToDrafts < ActiveRecord::Migration
  def change
    add_column :drafts, :league_id, :integer
  end
end
