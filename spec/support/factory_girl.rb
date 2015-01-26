require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :team do
    name "name"
    user
    league
  end

  factory :player do
    first_name "first"
    last_name "last"
    position "QB"
    gsis_id 1
    height 8
    weight 8
    years_pro 2
    birthdate DateTime.now
  end

  factory :roster do
    team
    status "active"
    before(:create) do |roster|
      player = create(:player)
      roster.player_id = player.id
      roster.position = player.position
    end
  end

  factory :league do
    password "password"
    name "name"
    member_amount 8
    before(:create) do |league|
      user = create(:user)
      league.commissioner_id = user.id
    end
  end

end
