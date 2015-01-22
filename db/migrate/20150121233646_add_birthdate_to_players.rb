class AddBirthdateToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :birthdate, :string
  end
end
