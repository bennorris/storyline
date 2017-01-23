$(function () {
  $('form#new_story').submit(function(event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    var values = $(this).serialize();
    $.post('/stories', values)
      .done(function(data) {
        $("#user-story-full").text(data["full_story"]);
        $('a#next-user-story').attr('href', '/stories/' + data['id']);
        $('a#next-user-story').text('details');
        $('a#delete-your-story').attr('href', '/stories/' + data['id']);
        $('a#delete-your-story').text('delete');
        $('input#story_beginning').trigger("reset");
        $('input#story_beginning').val('');
        $('form#new_story').removeAttr('disabled');
        if (data['full_story']) {
          $('#success').text("Success! You can find your story below, in the 'Your Stories' section.");
        }
      })
      .fail(function(error) {
        console.log(error)
      });
  });
});
