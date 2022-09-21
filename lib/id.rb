module Id
  def team_name_from_team_id(id)
    @teams_data.each do |row|
      return row[:teamname] if id[0] == row[:team_id]
    end
  end
end
