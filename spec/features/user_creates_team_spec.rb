require "rails_helper"

feature "user creates team" do
  scenario "by joining a league with a shared league id" do
    initial_team_count = Team.count
    user = FactoryGirl.create(:user)
    commissioner = FactoryGirl.create(:user)
    league = League.create(
        name: "name",
        member_amount: "8",
        commissioner_id: commissioner.id)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    click_link "Join a League"
    fill_in "League ID", with: league.id
    click_button "Submit"
    fill_in "Name", with: "name"
    click_button "Create Team"

    expect(page).to have_content("Team created")
    expect(Team.count).to eq(initial_team_count + 1)
  end

  scenario "after creating a league" do
    initial_team_count = Team.count
    initial_league_count = League.count
    user = FactoryGirl.create(:user)
    league = League.new(
        name: "name",
        password: "password",
        member_amount: "8")

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
    fill_in "Name", with: "name"
    click_button "Create Team"

    expect(page).to have_content("Team created")
    expect(Team.count).to eq(initial_team_count + 1)
  end

  scenario "and receives errors when incorrectly filling out forms" do
    initial_team_count = Team.count
    user = FactoryGirl.create(:user)
    commissioner = FactoryGirl.create(:user)
    league = League.create(
        name: "name",
        member_amount: "8",
        commissioner_id: commissioner.id)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    click_link "Join a League"
    fill_in "League ID", with: league.id
    click_button "Submit"
    click_button "Create Team"

    expect(page).to have_content("Name can't be blank")
    expect(Team.count).to eq(initial_team_count)
  end

  scenario "and is given an error if not signed in" do
    commissioner = FactoryGirl.create(:user)
    league = League.create(
        name: "name",
        member_amount: "8",
        commissioner_id: commissioner.id)
    visit new_league_team_path(league)

    expect(page).to have_content("Must be signed in to do that.")
  end
end
