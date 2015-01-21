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

  factory :league do
    name "name"
    password "password"
    member_amount 14
  end

  factory :player do
    first_name "first"
    last_name "last"
    position "QB"
    gsis_id 1
    height 8
    weight 8
    years_pro 2
  end

  factory :roster do
    player
    team
    status "inactive"
  end

  factory :draft do
    year 20150901
    name "league name"
  end
end
