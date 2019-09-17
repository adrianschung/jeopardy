$(document).on('turbolinks:load', function() {
  console.log('loaded')
  $('#question_answer').select2({
    placeholder: "What is",
    allowClear: true
  });
})
