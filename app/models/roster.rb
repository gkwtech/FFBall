class Roster < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  validates :player_id, presence: true
  validates :team_id, presence: true
end
