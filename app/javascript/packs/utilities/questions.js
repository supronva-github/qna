$(document).on('turbolinks:load', function(){
  $('.question').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    console.log(questionId);
    $('form#edit-question-' + questionId).removeClass('hidden');
  });

  $('.vote-question a').on('ajax:success', function(e) {
    $(this).closest('.question').find('.question-rating span').text(JSON.parse(e.detail[2].responseText).rating);
  });
});
