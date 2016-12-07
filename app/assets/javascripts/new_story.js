$(function () {
  $('form').submit(function(event) {
    event.preventDefault();
    var values = $(this).serialize();
    var posting = $.post('/stories', values);
    posting.done(function(data) {
      $("#user-story-full").text(data["full_story"]);
      $('a#next-user-story').attr('href', '/stories/' + data['id']);
      $('a#next-user-story').text('details');
      $('a#delete-your-story').attr('href', '/stories/' + data['id']);
      $('a#delete-your-story').text('delete');
      $("form").trigger("reset");
      $('input').removeAttr('disabled');
      if (data['full_story']) {
        $('#success').text("Success! You can find your story below, in the 'Your Stories' section.");
      }
      getStories();
    });
  });
});
