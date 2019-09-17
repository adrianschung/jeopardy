class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
  end

  def update
    if current_question.answer.id.to_s == params[:question][:answer]
      current_game.answered_questions.create(question: current_question)
      redirect_to game_path(current_game)
    else
      redirect_to game_question_path(current_game, current_question)
    end
  end

  private

  helper_method :current_question, :current_game

  def current_question
    @question ||= Question.find(params[:id])
  end

  def current_game
    @game ||= Game.find(params[:game_id])
  end
end
