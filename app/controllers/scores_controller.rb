require 'net/http'
require 'uri'

class ScoresController < ApplicationController
  def view
    @week = params[:week]
    if @week.nil?
      @week = Param.week()
    end
    @games = fetch_games(@week)
    @picks = Pick.picks_hash(@week)

    annotate_games()
  end

  
    @@css_classes = {
        :home => {
            -1 => { :in_progress => :losing,  :final => :lost },
             0 => { :in_progress => :none,    :final => :won },
             1 => { :in_progress => :winning, :final => :won }
        },
        :away => {
            -1 => { :in_progress => :winning, :final => :won },
             0 => { :in_progress => :none,    :final => :won },
             1 => { :in_progress => :losing,  :final => :lost }
        }
    }

    def annotate_games
      @games.each do |game|
        home = game[:home]
        away = game[:away]

        home[:pick_count] = @picks[home[:team]]
        away[:pick_count] = @picks[away[:team]]
        home[:css] = :none
        away[:css] = :none

        status = home[:score].to_i <=> away[:score].to_i

        if home[:score] == '--'
          game[:status] = :not_started
        else
          if game[:time] == 'Final'
            game[:status] = :final
          else
            game[:status] = :in_progress
          end

          home[:css] = @@css_classes[:home][status][game[:status]] if home[:pick_count] > 0
          away[:css] = @@css_classes[:away][status][game[:status]] if away[:pick_count] > 0 
        end
      end
    end

    def fetch_games(week)
      uri = URI.parse("http://scores.espn.go.com/nfl/scoreboard?seasonYear=2011&seasonType=2&weekNumber=#{week}")
      res = Net::HTTP.start(uri.host, uri.port) { |http|
        http.get(uri.request_uri)
      }

      body = res.body
      if body.nil?
        return data
      end

      game_texts = body.scan(/<div class="game-header">.*?<div class="game-links">/m)

      game_texts.collect { |game_text|

        if game_text =~ /<div class="game-status">.*?statusText">(.*?)</
          time = $1
        end

        {
          :time => time,
          :away => parse_team_info(game_text, "visitor", time),
          :home => parse_team_info(game_text, "home", "")
        }
      }
    end

    @@espn_hash = {
            'nyj' => 'NYJ',
            'oak' => 'OAK',
            'bal' => 'BAL',
            'stl' => 'STL',
            'kan' => 'KC',
            'sdg' => 'SD',
            'gnb' => 'GB',
            'chi' => 'CHI',
            'ari' => 'ARI',
            'sea' => 'SEA',
            'atl' => 'ATL',
            'tam' => 'TB',
            'pit' => 'PIT',
            'ind' => 'IND',
            'nwe' => 'NE',
            'buf' => 'BUF',
            'sfo' => 'SF',
            'cin' => 'CIN',
            'mia' => 'MIA',
            'cle' => 'CLE',
            'den' => 'DEN',
            'ten' => 'TEN',
            'det' => 'DET',
            'min' => 'MIN',
            'hou' => 'HOU',
            'nor' => 'NO',
            'nyg' => 'NYG',
            'phi' => 'PHI',
            'jac' => 'JAC',
            'car' => 'CAR',
            'was' => 'WAS',
            'dal' => 'DAL'
    }

    def parse_team_info(game_text, side, alt)
      team_match = game_text.match(/<div class="team #{side}">.*?logo-small logo-nfl-small nfl-small-(.*?)"/)
      score_match = game_text.match(/<div class="team #{side}">.*?[ah]Total".*?(\d+)</)

      {
        :team => @@espn_hash[team_match[1]],
        :score => score_match[1],
        :alt => alt
      }
    end
end
