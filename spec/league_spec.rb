require 'spec_helper'
require './lib/league'

RSpec.describe League do
  before (:all) do
    fixture_game_path = 'fixture/games.csv'
    fixture_team_path = 'fixture/teams.csv'
    fixture_game_teams_path = 'fixture/game_teams.csv'

    locations = {
      games: fixture_game_path,
      teams: fixture_team_path,
      game_teams: fixture_game_teams_path
    }
    
    @league = League.new(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@league).to be_an_instance_of(League)
    end
  end

  describe '#count_of_teams' do
    it 'returns the number of teams in the league' do
      expect(@league.count_of_teams).to eq 32
    end
  end

  describe '#best_offense' do
    it 'returns the team with highest average number of goals scored per game all seasons' do
      expect(@league.best_offense).to eq "New England Revolution"
    end
  end

  describe '#worst_offense' do
    it 'returns the worst offense' do
      expect(@league.worst_offense).to eq "Houston Dash"
    end
  end

  describe '#highest_scoring_visitor' do
    it "#highest_scoring_visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq "Chicago Red Stars"
    end
  end

  describe '#highest_scoring_home_team' do
    it "#highest_scoring_home_team" do
      expect(@league.highest_scoring_home_team).to eq "New England Revolution"
    end
  end

  describe '#lowest_scoring_visitor' do
    it "#lowest_scoring_visitor" do
      expect(@league.lowest_scoring_visitor).to eq "Houston Dash"
    end
  end

  describe '#lowest_scoring_home_team' do
    it "#lowest_scoring_home_team" do
      expect(@league.lowest_scoring_home_team).to eq "Sporting Kansas"
    end
  end

  # describe '#team_goals_per_game' do
    # it '#team_goals_per_game' do
    #   team_with_goals = {
    #     "6" => [3,3,2,3,3,3,4,2,1,2],    
    #     "3" => [2,2,1,2,1,2,2,2,2,1],    
    #     "5" => [0,1,1,0,3],    
    #     "17" => [1],    
    #     "16" => [2,5,3],    
    #     "25" => [3,3,2],    
    #     "30" => [2,2,1,3,1,2,2,1],    
    #     "19" => [2,2,0,4,1,1],    
    #     "15" => [3,1,3,3,3,3,2,2,2,4,1,2,2],    
    #     "14" => [2,4,2,2,1,2,2],    
    #     "8" => [1,2,1,4,2,1],    
    #     "10" => [2,2,2,2,1,1],    
    #     "29" => [1,1,3,3,1,2],    
    #     "52" => [2,2,5,1,4,2],    
    #     "18" => [1,3,2,2,2,2],    
    #     "20" => [3,1],    
    #     "28" => [4,2],    
    #     "4" => [2,2],    
    #     "26" => [2],    
    #     "24" => [2],    
    #     "22" => [2],    
    #     "12" => [3],    
    #     "13" => [0]    
    #   }
    #   expect(@league.team_goals_per_game).to eq(team_with_goals)
    # end
  # end

    # describe '#away_goals_per_team' do
  #   it 'returns a hash of away game goals' do
  #     away_goals = {
  #       "6" => [2,3,3,4,2],    
  #       "3" => [2,2,1,2],    
  #       "5" => [1,0],    
  #       "17" => [1],    
  #       "16" => [3],    
  #       "25" => [3,3],    
  #       "30" => [2,1,2,1],    
  #       "19" => [0,4,1],    
  #       "15" => [1,3,3,2,4,1,2],    
  #       "14" => [2,4,1],    
  #       "8" => [1,4,1],    
  #       "10" => [2,2,1],    
  #       "29" => [1,1,3,1,2],    
  #       "52" => [2,2,4],    
  #       "18" => [2,2,2],    
  #       "20" => [3,1],    
  #       "4" => [2,2],      
  #       "13" => [0] 
  #     }
  #     expect(@league.hoa_goals_per_team("away")).to eq(away_goals)
  #   end
  
  #   it 'returns a hash with home game goals per team' do
  #     home_goals = {
  #       "6" => [3,3,3,2,1],    
  #       "3" => [1,2,2,2,2,1],    
  #       "5" => [0,1,3],      
  #       "16" => [2,5],    
  #       "25" => [2],    
  #       "30" => [2,3,1,2],    
  #       "19" => [2,2,1],    
  #       "15" => [3,3,3,2,2,2],    
  #       "14" => [2,2,2,2],    
  #       "8" => [1,2,2],    
  #       "10" => [2,2,1],    
  #       "29" => [3],    
  #       "52" => [5,1,2],    
  #       "18" => [1,3,2],  
  #       "28" => [4,2],     
  #       "26" => [2],    
  #       "24" => [2],    
  #       "22" => [2],    
  #       "12" => [3],    
  #     }
  #     expect(@league.hoa_goals_per_team("home")).to eq(home_goals)
  #   end
  # end

  describe '#team_goal_average' do
    it 'returns average goals for all games for each team' do
      team_with_goal_average = {
        "6" => 2.6,    
        "3" => 1.7,    
        "5" => 1.0,    
        "17" => 1.0,    
        "16" => 3.333,    
        "25" => 2.667,    
        "30" => 1.75,    
        "19" => 1.667,    
        "15" => 2.385,    
        "14" => 2.143,    
        "8" => 1.833,    
        "10" => 1.667,    
        "29" => 1.833,    
        "52" => 2.667,    
        "18" => 2.0,    
        "20" => 2.0,    
        "28" => 3.0,    
        "4" => 2.0,    
        "26" => 2.0,    
        "24" => 2.0,    
        "22" => 2.0,    
        "12" => 3.0,    
        "13" => 0.0    
      }
      expect(@league.team_goal_average).to eq(team_with_goal_average)
    end

    it 'returns average goals for all home games for each team' do
      home_goals = {
        "6" => 2.4,    
        "3" => 1.667,    
        "5" => 1.333,      
        "16" => 3.5,    
        "25" => 2.0,    
        "30" => 2.0,    
        "19" => 1.667,    
        "15" => 2.5,    
        "14" => 2.0,    
        "8" => 1.667,    
        "10" => 1.667,    
        "29" => 3.0,    
        "52" => 2.667,    
        "18" => 2.0,  
        "28" => 3.0,     
        "26" => 2.0,    
        "24" => 2.0,    
        "22" => 2.0,    
        "12" => 3.0,    
      }
      expect(@league.team_goal_average('home')).to eq(home_goals)
    end

    it 'returns average goals for all away games for each team' do
      away_goals = {
        "6" => 2.8,    
        "3" => 1.75,    
        "5" => 0.5,    
        "17" => 1.0,    
        "16" => 3.0,    
        "25" => 2.0,    
        "30" => 1.5,    
        "19" => 1.667,    
        "15" => 2.143,    
        "14" => 2.333,    
        "8" => 2.0,    
        "10" => 1.667,    
        "29" => 1.6,    
        "52" => 2.667,    
        "18" => 2,    
        "20" => 2,    
        "4" => 2,      
        "13" => 0, 
      }
      expect(@league.team_goal_average('away')).to eq(away_goals)
    end
  end

  describe '#team_name_from_id_average' do
    it 'returns the team name for the given array of team id and average goals' do
      team_with_goal_average = {
        "6" => 2.6,    
        "3" => 1.7,    
        "5" => 1.0,    
        "17" => 1.0,    
        "16" => 3.333,    
        "25" => 2.667,    
        "30" => 1.75,    
        "19" => 1.667,    
        "15" => 2.385,    
        "14" => 2.143,    
        "8" => 1.833,    
        "10" => 1.667,    
        "29" => 1.833,    
        "52" => 2.667,    
        "18" => 2.0,    
        "20" => 2.0,    
        "28" => 3.0,    
        "4" => 2.0,    
        "26" => 2.0,    
        "24" => 2.0,    
        "22" => 2.0,    
        "12" => 3.0,    
        "13" => 0.0    
      }
      expect(@league.team_goal_average).to eq(team_with_goal_average)
      high_average = team_goal_average.max_by{ |id, average| average }
      expect(@league.team_name_from_id_average(high_average)).to eq("New England Revolution")
    end
  end
end

