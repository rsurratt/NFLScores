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

  private
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
          if game[:time] == 'FINAL'
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


        {
          :date => date,
          :time => time,
          :away => { :team => teams_match[0][0], :score => scores_match[0][0], :alt => date },
          :home => { :team => teams_match[1][0], :score => scores_match[1][0], :alt => time }
        }
      }
    end
end
