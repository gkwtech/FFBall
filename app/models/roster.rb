class Roster < ActiveRecord::Base
  belongs_to :team
  has_many :players
end
