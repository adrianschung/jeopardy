class GamesController < ApplicationController
  def index
    @games = Game.where(status: [0, 1])
    @my_games = current_user.games
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
      @game.update(excluded: {ids:[]})
      Jeopardy::CreateGame.call(@game)
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

  def start
    current_game_id.update(status: 'selecting', answerer_id: current_user.id)
    ActionCable.server.broadcast("game_#{current_game.id}", action: 'start', user: current_user.id)
  end

  def select
    question = Question.find(params[:question_id])
    current_game_id.update(status: 'answering', answerer_id: nil, question_id: question.id)
    ActionCable.server.broadcast("game_#{current_game.id}", action: 'select', question: question.description, ids: [])
  end

  def buzz
    if current_game_id.answerer_id.nil?
      current_game_id.update(answerer_id: current_user.id)
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'buzz', user: current_user.id, name: current_user.name)
    end
  end

  def answer
    question = current_game_id.question
    points = question.value
    if question.answer.id.to_s == params[:game][:answer]
      current_game.answered_questions.create(question: question)
      current_game.update(status: 'selecting', question_id: nil, excluded: {ids:[]})
      current_game.game_users.where(user:current_user).first.increment!(:points, points)
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'answered', user: current_user.id, question: question.id, points: points_hash)
    else
      exclude_user
      current_game.update(answerer_id: nil)
      ActionCable.server.broadcast("game_#{current_game_id.id}", action: 'select', question: question.description, ids: current_game_id.excluded['ids'])
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

  def exclude_user
    excluded_ids = current_game.excluded['ids']
    excluded_ids << current_user.id
    current_game.update(excluded: {ids: excluded_ids})
  end

  def excluded_ids
    current_game.excluded['ids']
  end

  def points_hash
    points_hash = Hash.new
    current_game.game_users.each {|user| points_hash[user.user_id] = user.points}
    return points_hash
  end
end
