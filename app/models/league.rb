class League < ActiveRecord::Base
  belongs_to :user
  has_many :teams
  has_many :drafts

  validates :name, presence: true
end
