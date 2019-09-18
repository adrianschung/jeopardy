$(document).on('turbolinks:load', function() {
  $('#question_answer').select2({
    placeholder: "What is",
    allowClear: true
  });
})
