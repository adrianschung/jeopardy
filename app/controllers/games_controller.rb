class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game.game_users.create(user: current_user)
      flash[:notice] = "Game created!"
      redirect_to game_path(@game)
    else
      flash[:alert] = "Unable to create game."
      render :new
    end
  end

  def join
    game = Game.find(params[:game_id])
    game.game_users.new(user: current_user)
    if game.save
      flash[:notice] = "Joined game."
      redirect_to game_path(game)
    else
      flash[:alert] = "Unable to join game."
      redirect_to games_path
    end
  end

  private
  helper_method :current_answered_ids, :current_game

  def game_params
    params.require(:game).permit(:name)
  end

  def current_answered_ids
    @answered_questions ||= current_game.answered_ids
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
