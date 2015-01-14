class AddMemberAmountToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :member_amount, :string, null: false
  end
end
