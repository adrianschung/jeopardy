$(document).on('turbolinks:load', function() {
  var gameId = $('[data-channel-subscribe="game"]').data('game-id')

  function processData(data) {
    if (data.action == 'start') {
      $('#game-box').hide();
      displayBoard(data.user);
    } else if (data.action == 'select') {
      displayQuestion(data.question);
      resetBuzzer(data.ids)
    } else if (data.action == 'buzz') {
      resetAnswering(data.user, data.name);
    } else if (data.action == 'answered') {
      console.log(data.points)
      questionAnswered(data.user, data.question, data.points)
    }
  }

  App.room = App.cable.subscriptions.create(
    {
      channel: "GameChannel",
      id: gameId
    }, 
    {
      received: function(data){
        processData(data);
      }
    }
  )
}) 
