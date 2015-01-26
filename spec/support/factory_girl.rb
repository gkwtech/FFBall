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
    player
    team
    status "inactive"
  end

end
