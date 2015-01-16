class Pick < ActiveRecord::Base
  belongs_to :round
  belongs_to :team
  has_one :player
end
