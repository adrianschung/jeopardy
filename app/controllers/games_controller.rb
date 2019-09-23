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
    current_game.game_users.new(user: current_user)
    if current_game.save
      flash[:notice] = "Joined game."
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'join', html: render_players)
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'full') if current_game.users.count == 3
      redirect_to game_path(current_game)
    else
      flash[:alert] = "Unable to join game."
      redirect_to games_path
    end
  end

  def start
    current_game.update(status: 'selecting', answerer_id: current_user.id)
    ActionCable.server.broadcast("game_#{current_game.id}", action: 'start', user: current_user.id)
  end

  def select
    question = Question.find(params[:question_id])
    category = question.category
    current_game.update(status: 'selected', answerer_id: nil, question_id: question.id)
    ActionCable.server.broadcast("game_#{current_game.id}", action: 'select', category: category.name, question: question.description, ids: [])
  end

  def buzz
    if current_game.answerer_id.nil?
      current_game.update(status: 'answering', answerer_id: current_user.id)
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'buzz', user: current_user.id, name: current_user.name)
    end
  end

  def answer
    question = current_game.question
    points = question.value
    if question.answer.id.to_s == params[:game][:answer]
      current_game.answered_questions.create(question: question)
      current_game.update(status: 'selecting', question_id: nil, excluded: {ids:[]})
      current_game.game_users.where(user:current_user).first.increment!(:points, points)
      ActionCable.server.broadcast("game_#{current_game.id}", action: 'answered', user: current_user.id, question: question.id, points: points_hash)
    else
      exclude_user
      if current_game.excluded['ids'].count == 3
        current_game.answered_questions.create(question: question)
        current_game.update(status: 'selecting', question_id: nil, excluded: {ids:[]})
        ActionCable.server.broadcast("game_#{current_game.id}", action: 'answered', user: current_user.id, question: question.id)
      else
        current_game.update(answerer_id: nil)
        ActionCable.server.broadcast("game_#{current_game.id}", action: 'reset', ids: current_game.excluded['ids'])
      end
    end
  end

  private
  helper_method :current_answered_ids, :current_game

  def render_players
    ApplicationController.render(partial: 'games/players', locals: {current_game: current_game})
  end

  def game_params
    params.require(:game).permit(:name)
  end

  def current_answered_ids
    @answered_questions ||= current_game.answered_ids
  end

  def current_game
    @game ||= Game.find(params[:id]) rescue nil
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
