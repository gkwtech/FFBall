class Player < ActiveRecord::Base
  belongs_to :team
  has_many :rosters

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true

  def age
    birthday = self.birthdate
    birthday = Date.parse(birthday)
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def self.search(query)
    where("last_name like ?", "%#{query}%")
  end

  paginates_per 50
end
