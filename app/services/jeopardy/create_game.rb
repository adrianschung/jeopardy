module Jeopardy
  class CreateGame < ApplicationService

    def initialize(game)
      @game = game
    end

    def call
      get_categories
      create_game_categories
    end

    private

    def get_categories
      @ids = Category.pluck(:id).shuffle[0..4]
    end

    def create_game_categories
      @ids.each{ |id| @game.game_categories.create(category_id: id) }
    end
  end
end