module ScoresHelper
  @@teamdata = {
    'NE'  => { :abbr => 'NE',   :place => 'New England',   :mascot => 'Patriots' },
    'HOU' => { :abbr => 'HOU',  :place => 'Houston',       :mascot => 'Texans' },
    'NYJ' => { :abbr => 'NYJ',  :place => 'New York',      :mascot => 'Jets' },
    'BUF' => { :abbr => 'BUF',  :place => 'Buffalo',       :mascot => 'Bills' },
    'OAK' => { :abbr => 'OAK',  :place => 'Oakland',       :mascot => 'Raiders' },
    'BAL' => { :abbr => 'BAL',  :place => 'Baltimore',     :mascot => 'Ravens' },
    'JAC' => { :abbr => 'JAC',  :place => 'Jacksonville',  :mascot => 'Jaguars' },
    'CIN' => { :abbr => 'CIN',  :place => 'Cincinnati',    :mascot => 'Bengals' },
    'TEN' => { :abbr => 'TEN',  :place => 'Tennessee',     :mascot => 'Titans' },
    'DEN' => { :abbr => 'DEN',  :place => 'Denver',        :mascot => 'Broncos' },
    'CLE' => { :abbr => 'CLE',  :place => 'Cleveland',     :mascot => 'Browns' },
    'SD'  => { :abbr => 'SD',   :place => 'San Diego',     :mascot => 'Chargers' },
    'PIT' => { :abbr => 'PIT',  :place => 'Pittsburgh',    :mascot => 'Steelers' },
    'MIA' => { :abbr => 'MIA',  :place => 'Miami',         :mascot => 'Dolphins' },
    'KC'  => { :abbr => 'KC',   :place => 'Kansas City',   :mascot => 'Chiefs' },
    'IND' => { :abbr => 'IND',  :place => 'Indianapolis',  :mascot => 'Colts' },

    'WAS' => { :abbr => 'WAS',  :place => 'Washington',    :mascot => 'Redskins' },
    'DET' => { :abbr => 'DET',  :place => 'Detroit',       :mascot => 'Lions' },
    'GB'  => { :abbr => 'GB',   :place => 'Green Bay',     :mascot => 'Packers' },
    'NO'  => { :abbr => 'NO',   :place => 'New Orleans',   :mascot => 'Saints' },
    'SF'  => { :abbr => 'SF',   :place => 'San Francisco', :mascot => '49ers' },
    'DAL' => { :abbr => 'DAL',  :place => 'Dallas',        :mascot => 'Cowboys' },
    'CHI' => { :abbr => 'CHI',  :place => 'Chicago',       :mascot => 'Bears' },
    'ATL' => { :abbr => 'ATL',  :place => 'Atlanta',       :mascot => 'Falcons' },
    'ARI' => { :abbr => 'ARI',  :place => 'Arizona',       :mascot => 'Cardinals' },
    'TB'  => { :abbr => 'TB',   :place => 'Tampa Bay',     :mascot => 'Buccaneers' },
    'PHI' => { :abbr => 'PHI',  :place => 'Philadelphia',  :mascot => 'Eagles' },
    'NYG' => { :abbr => 'NYG',  :place => 'New York',      :mascot => 'Giants' },
    'CAR' => { :abbr => 'CAR',  :place => 'Carolina',      :mascot => 'Panthers' },
    'STL' => { :abbr => 'STL',  :place => 'St. Louis',     :mascot => 'Rams' },
    'MIN' => { :abbr => 'MIN',  :place => 'Minnesota',     :mascot => 'Vikings' },
    'SEA' => { :abbr => 'SEA',  :place => 'Seattle',       :mascot => 'Seahawks' },
  }

  def fullname(team)
    if @@teamdata[team].nil?
      "NOT FOUND #{team}"
    else
      "#{@@teamdata[team][:place]} #{@@teamdata[team][:mascot]}"
    end
  end

  def score_or_time(score, time)
    (score == '--') ? time : score
  end

  def sorted_teams()
    teams = @@teamdata.values
    teams.sort { |a,b| fullname(a[:abbr]) <=> fullname(b[:abbr]) }
  end

  def teams_for_select()
    teams = sorted_teams()
    teams.collect { |t| ["#{fullname(t[:abbr])} (#{t[:abbr]})", t[:abbr]] }    
  end

end
