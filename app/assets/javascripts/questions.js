$(document).on('turbolinks:load', function() {
  $('#game_answer').select2({
    placeholder: "What is",
    minimumInputLength: 1,
    allowClear: true
  });
})
