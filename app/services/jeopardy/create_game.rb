module Jeopardy
  class CreateGame < ApplicationService

    def initialize(name)
      @name = name
    end

    def call
      get_categories
      create_game
    end

    private

    def get_categories
      @ids = Category.pluck(:id).shuffle[0..4]
    end

    def create_game
      @game = Game.create(name: @name)
      @ids.each{ |id| @game.game_categories.create(category_id: id) }
    end
  end
end