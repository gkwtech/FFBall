class League < ActiveRecord::Base
  has_many :users, through: :teams
  has_many :teams
  has_many :drafts

  validates :name, presence: true
  validates :member_amount, presence: true

  def has_drafted?
    if self.drafts.empty?
      return false
    else
      self.drafts.each do |draft|
        if draft.created_at.year == Time.now.year && draft.picks.count == (self.member_amount.to_i * self.max_players)
          return true
        end
      end
    end
    false
  end
end










