 $(document).on('turbolinks:load', function() {
   userId = $('#user').data('id');
  $('#game_answer').select2({
    placeholder: "What is",
    minimumInputLength: 1,
    allowClear: true
  });
})

var userId;

function displayBoard(id, question = '') {
  $('.question-' + question).html("")
  resetBoard();
  if (id === userId) {
    $('#selection-board').show();
  } else {
    $('#board').show();
  }
}

function questionAnswered(id, questionId = '', points = undefined) {
  if (points) {
    updatePoints(points)
  }
  removeQuestion(questionId);
  displayBoard(id);
}

function displayQuestion(category) {
  resetBoard();
  $('#buzzer').show();
  $('#current-category').text(category).show();
  $('#question-box #current-question').show();
  revealQuestion(moveCover);
}

function resetBuzzer(excludedIds = []) {
  hideAnswering();
  if ($.inArray(userId, excludedIds) !== -1) {
    $('#buzzed').show();
  } else {
    $('#buzzer').show();
  }
  moveCover();;
}

function resetAnswering(id = '', name = 'someone') {
  $('#current-question').stop();
  hideBuzzer();
  $('#answer-name').text(name);
  if (id == userId) {
    $('#answer-form').show();
  } else {
    $('#answer-waiting').show();
  }
}

function resetBoard() {
  $('.board').hide();
}

function removeQuestion(questionId) {
  $('.question-' + questionId).html("");
}

function revealQuestion(callback) {
  $('#current-question').width('0');
  callback();
}

function moveCover() {
  $('#current-question').animate({width:'100%'}, 5000);
}

function hideBuzzer() {
  $('#buzzer, #buzzed').hide();
}

function hideAnswering() {
  $('#answer-form, #answer-waiting').hide();
}

function updatePoints(pointsHash) {
  $.each(pointsHash, function(key, val) {
    $(".points-" + key).text(val);
  })
}