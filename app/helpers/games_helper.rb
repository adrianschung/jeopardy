module GamesHelper
  def buzzer_enabled?
    !current_game.excluded['ids'].include?(current_user.id) && current_game.status == "selected"
  end

  def buzzer_disabled?
    current_game.excluded['ids'].include?(current_user.id) && current_game.status == "selected"
  end

  def someone_answering
    current_game.status == "answering" && current_game.answerer_id != current_user.id ? "block" : "none"
  end
end
