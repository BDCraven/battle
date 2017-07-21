require 'sinatra/base'
require_relative './lib/player'
require_relative './lib/game'

class Battle < Sinatra::Base
  enable :sessions

  get '/' do
    # 'Testing infrastructure working!'
    erb :index
  end

  post '/names' do
    player_1 = Player.new(params[:player_1_name])
    player_2 = Player.new(params[:player_2_name])
    $game = Game.new(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    @game = $game
    erb :play
  end


  # start the server if ruby file executed directly
  run! if app_file == $0

  get '/attack' do
    @game = $game
    @game.attack(@game.player_2)
    @game.switch_turns
    erb :attack
  end
end
