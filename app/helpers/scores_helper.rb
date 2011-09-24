module ScoresHelper
  @@teamdata = {
    'NE'  => { :place => 'New England',   :mascot => 'Patriots' },
    'HOU' => { :place => 'Houston',       :mascot => 'Texans' },
    'NYJ' => { :place => 'New York',      :mascot => 'Jets' },
    'BUF' => { :place => 'Buffalo',       :mascot => 'Bills' },
    'OAK' => { :place => 'Oakland',       :mascot => 'Raiders' },
    'BAL' => { :place => 'Baltimore',     :mascot => 'Ravens' },
    'JAC' => { :place => 'Jacksonville',  :mascot => 'Jaguars' },
    'CIN' => { :place => 'Cincinnati',    :mascot => 'Bengals' },
    'TEN' => { :place => 'Tennessee',     :mascot => 'Titans' },
    'DEN' => { :place => 'Denver',        :mascot => 'Broncos' },
    'CLE' => { :place => 'Cleveland',     :mascot => 'Browns' },
    'SD'  => { :place => 'San Diego',     :mascot => 'Chargers' },
    'PIT' => { :place => 'Pittsburgh',    :mascot => 'Steelers' },
    'MIA' => { :place => 'Miami',         :mascot => 'Dolphins' },
    'KC'  => { :place => 'Kansas City',   :mascot => 'Chiefs' },
    'IND' => { :place => 'Indianapolis',  :mascot => 'Colts' },

    'WAS' => { :place => 'Washington',    :mascot => 'Redskins' },
    'DET' => { :place => 'Detroit',       :mascot => 'Lions' },
    'GB'  => { :place => 'Green Bay',     :mascot => 'Packers' },
    'NO'  => { :place => 'New Orleans',   :mascot => 'Saints' },
    'SF'  => { :place => 'San Francisco', :mascot => '49ers' },
    'DAL' => { :place => 'Dallas',        :mascot => 'Cowboys' },
    'CHI' => { :place => 'Chicago',       :mascot => 'Bears' },
    'ATL' => { :place => 'Atlanta',       :mascot => 'Falcons' },
    'ARI' => { :place => 'Arizona',       :mascot => 'Cardinals' },
    'TB'  => { :place => 'Tampa Bay',     :mascot => 'Buccaneers' },
    'PHI' => { :place => 'Philadelphia',  :mascot => 'Eagles' },
    'NYG' => { :place => 'New York',      :mascot => 'Giants' },
    'CAR' => { :place => 'Carolina',      :mascot => 'Panthers' },
    'STL' => { :place => 'St. Louis',     :mascot => 'Rams' },
    'MIN' => { :place => 'Minnesota',     :mascot => 'Vikings' },
    'SEA' => { :place => 'Seattle',       :mascot => 'Seahawks' },
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

end
