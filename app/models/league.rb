class League < ActiveRecord::Base
  belongs_to :user
  has_many :teams
  has_many :drafts

  validates :name, presence: true
  validates :member_amount, presence: true

  def has_drafted?
    if self.drafts.empty?
      return false
    else
      self.drafts.each do |draft|
        if draft.year.to_i == Time.now.year
          return true
        end
      end
    end
    false
  end
end










