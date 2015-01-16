class Draft < ActiveRecord::Base
  has_many :rounds
  has_many :teams
  has_many :players
end
