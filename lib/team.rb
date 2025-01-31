require './lib/futbol_data.rb'
require './lib/id.rb'
require_relative 'sucess_rate.rb'

class Team < FutbolData
  include Id
  include SuccessRate
  
  attr_reader :games_data

  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    super(teams_data, game_teams_data)
  end

  def team_info(index)
    team_info_hash = {}
    @teams_data.map do |row|
      next unless row[:team_id] == index

      team_info_hash[:team_id.to_s] = row[:team_id]
      team_info_hash[:franchise_id.to_s] = row[:franchiseid]
      team_info_hash[:team_name.to_s] = row[:teamname]
      team_info_hash[:abbreviation.to_s] = row[:abbreviation]
      team_info_hash[:link.to_s] = row[:link]
    end
    team_info_hash
  end
  def average_win_percentage(team)
    win_count = 0
    loss_count = 0
    total_games = 0
    @games_data.map do |row|
      if row[:away_team_id] == team
        if row[:away_goals] > row[:home_goals]
          win_count += 1
        else
          loss_count += 1
        end
      elsif row[:home_team_id] == team
        if row[:home_goals] > row[:away_goals]
          win_count += 1
        else
          loss_count += 1
        end
      end
    end
    total_games = (win_count + loss_count)
    (win_count.to_f / total_games.to_f).round(2)
  end

  def most_goals_scored(team)
    score_array = []
    @games_data.map do |row|
      if row[:away_team_id] == team
        score_array << row[:away_goals]
      elsif row[:home_team_id] == team
        score_array << row[:home_goals]
      end
    end
    score_array.sort!
    score_array.pop.to_i
  end

  def fewest_goals_scored(team)
    score_array = []
    @games_data.map do |row|
      if row[:away_team_id] == team
        score_array << row[:away_goals]
      elsif row[:home_team_id] == team
        score_array << row[:home_goals]
      end
    end
    score_array.sort!
    score_array.shift.to_i
  end

  def favorite_opponent(team)
    team_wins = win_loss_hashes(team)[0]
    team_losses = win_loss_hashes(team)[1]
    min_win_rate = 100
    min_win_rate_team = nil
    team_wins.each do |key, value|
      next unless key != team

      total_games = value + team_losses[key]
      win_rate = value.to_f / total_games
      if win_rate < min_win_rate
        min_win_rate = win_rate
        min_win_rate_team = key
      end
    end
    team_name_from_team_id(min_win_rate_team.split)
  end

  def rival(team)
    team_wins = win_loss_hashes(team)[0]
    team_losses = win_loss_hashes(team)[1]
    max_win_rate = 0
    max_win_rate_team = nil
    team_wins.each do |key, value|
      next unless key != team

      total_games = value + team_losses[key]
      win_rate = value.to_f / total_games
      if win_rate > max_win_rate
        max_win_rate = win_rate
        max_win_rate_team = key
      end
    end
    team_name_from_team_id(max_win_rate_team.split)
  end

  def win_loss_hashes(team)
    team_wins = Hash.new(0)
    team_losses = Hash.new(0)
    @games_data.map do |row|
      if row[:away_team_id] == team
        if row[:away_goals] >= row[:home_goals]
          team_losses[row[:home_team_id]] += 1
          team_wins[row[:home_team_id]] += 0 unless team_wins.include?(row[:home_team_id])
        else
          team_wins[row[:home_team_id]] += 1
        end
      elsif row[:home_team_id] == team
        if row[:home_goals] >= row[:away_goals]
          team_losses[row[:away_team_id]] += 1
          team_wins[row[:home_team_id]] += 0 unless team_wins.include?(row[:home_team_id])
        else
          team_wins[row[:away_team_id]] += 1
        end
      end
    end
    rival_wins_and_losses = []
    rival_wins_and_losses << team_wins
    rival_wins_and_losses << team_losses
    rival_wins_and_losses
  end

  def season 
    @games_data.map { |row| row[:season] }.uniq
  end

  def season_hash(team)
    hash = Hash.new {|h, k| h[k] = { games_won: 0, games_played: 0 }}
    season.select { |year| team_games_played_in_a_season = @games_data.select { |row| row[:season] == year && (row[:away_team_id] == team || row[:home_team_id] == team)}
    team_games_played_in_a_season.select { |game_row|
      games_played = @game_teams_data.find { |game_team_row| game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team}
        hash[year][:games_won] += 1 if games_played[:result] == 'WIN'
        hash[year][:games_played] += 1}}
    hash
  end 

  def season_average_percentage(team)
    season_average_percentage = Hash.new
    season_hash(team).each {|year, totals| season_average_percentage[year] = (totals[:games_won].to_f / totals[:games_played]).round(4)}
    season_average_percentage
  end

  def best_season(team)
    season_record = highest_success_rate(season_average_percentage(team))
    season_record[0]
  end

  def worst_season (team)
    season_record = lowest_success_rate(season_average_percentage(team))
    season_record[0]
  end

end
