class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :players
  has_many :rosters

  validates :name, presence: true
end
