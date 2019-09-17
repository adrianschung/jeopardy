class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  helper_method :current_answered_ids, :current_game

  def current_answered_ids
    @answered_questions ||= current_game.answered_ids
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
