require "rails_helper"

feature "user creates league" do
  scenario "and receives confirmation when correctly filling out forms" do
    initial_league_count = League.count
    user = FactoryGirl.create(:user)
    league = League.new(name: "name", password: "password", member_amount: "8")

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    click_link "Create a League Now"
    fill_in "Name", with: league.name
    fill_in "Password", with: league.password
    select league.member_amount, from: "league[member_amount]"
    click_button "Create League"

    expect(page).to have_content("League created")
    expect(League.count).to eq(initial_league_count + 1)
  end

  scenario "and receives errors when incorrectly filling out forms" do
    user = FactoryGirl.create(:user)
    league = League.new(name: "name", password: "password", member_amount: "8")

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    visit new_league_path
    click_button "Create League"

    expect(page).to have_content("Name can't be blank")
  end

  scenario "and is given an error if not signed in" do
    visit new_league_path

    expect(page).to have_content("Must be signed in to do that.")
  end
end
