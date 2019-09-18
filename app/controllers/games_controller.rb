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
    current_game_id.game_users.new(user: current_user)
    if current_game_id.save
      flash[:notice] = "Joined game."
      redirect_to game_path(current_game_id)
    else
      flash[:alert] = "Unable to join game."
      redirect_to games_path
    end
  end

  def select
    question = params[:question_id]
    current_game_id.update(status: 'answering', answerer_id: nil, question_id: question)
    redirect_to game_path(current_game_id)
  end

  def start
    Jeopardy::CreateGame.call(current_game_id)
    current_game_id.update(status: 'selecting', answerer_id: current_user.id)
    redirect_to game_path(current_game_id)
  end

  def buzz
    if current_game_id.answerer_id.nil?
      current_game_id.update(answerer_id: current_user.id)
    end
    redirect_to game_path(current_game_id)
  end

  def answer
    question = current_game_id.question
    if question.answer.id.to_s == params[:game][:answer]
      current_game.answered_questions.create(question: question)
      current_game.update(status: 'selecting', question_id: nil)
      redirect_to game_path(current_game_id)
    else
      current_game.update(answerer_id: nil)
      redirect_to game_path(current_game_id)
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
    @game ||= Game.find(params[:game_id])
  end

  def current_game_id
    @game ||= Game.find(params[:game_id])
  end
end
