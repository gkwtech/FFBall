require "rails_helper"

feature "user views free agents" do
  scenario "but is unable to do so if not signed in" do
    league = FactoryGirl.create(:league)
    visit league_players_path(league)
    expect(page).to have_content("Must be signed in to do that.")
  end

  scenario "and adds a player" do
    player = FactoryGirl.create(:player)
    team = FactoryGirl.create(:team)
    initial_players_count = team.players.count

    visit new_user_session_path
    fill_in "Email", with: team.user.email
    fill_in "Password", with: team.user.password
    click_button "Log in"

    visit league_players_path(team.league)
    click_button "Add Player"
    expect(page).to have_content("#{player.first_name} #{player.last_name} added")
    expect(team.players.count).to eq(initial_players_count + 1)
  end
end
