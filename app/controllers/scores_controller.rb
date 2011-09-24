require 'net/http'
require 'uri'

class ScoresController < ApplicationController
  def view
    @week = 2
    @games = fetch_games(@week)
  end

  private
    def fetch_games(week)
      uri = URI.parse("http://www.nfl.com/scores/2011/REG#{week}")
      res = Net::HTTP.start(uri.host, uri.port) { |http|
        http.get(uri.request_uri)
      }

      body = res.body
      if body.nil?
        return data
      end

      game_texts = body.scan(/<div class="new-score-box.*?class="share"/m)

      game_texts.collect { |game_text|

        date = /<span class="date">(.*?)<\/span>/.match(game_text)[1]
        time = /<span class="time-left" ?>(.*?)<\/span>/.match(game_text)[1]
        teams_match = game_text.scan(/<a href="\/teams\/profile\?team=(.*?)">/).uniq
        scores_match = game_text.scan(/<p class="total-score">(.*?)<\/p>/)

        { :date => date,
          :time => time,
          :away_team => teams_match[0][0],
          :home_team => teams_match[1][0],
          :away_score => scores_match[0][0],
          :home_score => scores_match[1][0]
        }
      }
    end
end
