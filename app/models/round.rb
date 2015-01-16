class Round < ActiveRecord::Base
  has_many :picks
  belongs_to :draft
end
