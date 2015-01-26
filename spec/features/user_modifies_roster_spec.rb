require "rails_helper"

feature "user modifies roster" do
  scenario "by moving a player from the bench to the starting lineup" do
    roster = FactoryGirl.create(:roster)

    visit new_user_session_path
    fill_in "Email", with: roster.team.user.email
    fill_in "Password", with: roster.team.user.password
    click_button "Log in"

    visit league_team_path(roster.team.league, roster.team)
    select "BN", from: "roster[position]"
    click_button "Update"
    visit league_team_path(roster.team.league, roster.team)
    select roster.player.position, from: "roster[position]"
    click_button "Update"
    expect(page).to have_content("Lineup saved successfully.")
    expect(roster.position).to eq(roster.player.position)
  end

  scenario "by moving a player from the starting lineup to the bench" do
    roster = FactoryGirl.create(:roster)

    visit new_user_session_path
    fill_in "Email", with: roster.team.user.email
    fill_in "Password", with: roster.team.user.password
    click_button "Log in"

    visit league_team_path(roster.team.league, roster.team)
    select "BN", from: "roster[position]"
    click_button "Update"
    expect(page).to have_content("Lineup saved successfully.")
    expect(Roster.first.position).to eq("BN")
  end

  scenario "by dropping a player from the team" do
    roster = FactoryGirl.create(:roster)
    initial_players_count = roster.team.players.count

    visit new_user_session_path
    fill_in "Email", with: roster.team.user.email
    fill_in "Password", with: roster.team.user.password
    click_button "Log in"

    visit league_team_path(roster.team.league, roster.team)
    click_link "Drop Player"
    expect(page).to have_content("Player Dropped.")
    expect(roster.team.players.count).to eq(initial_players_count - 1)
  end
end
