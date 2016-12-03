$(function() {

// SCROLLING THROUGH ALL STORIES

$('#next-button').unbind('click').on('click', function() {

    var deStories = storiesArray.slice(0);

    $('#story-preview').empty();
    var figure = Math.floor(Math.random() * deStories.length)

   var rand = deStories[figure];
    if (rand[2] == false) {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><p><a href="/stories/'+rand[1]+'">Add a Sentence</a></p>'+
        '<a href="/stories/'+rand[1]+'">see contributors & more</a><br><br>');
        deStories.splice(figure,1);

    } else {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p>'+
        '<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>' +
        '<a href="/stories/'+rand[1]+'">see contributors & more</a><br><br>');
        deStories.splice(figure,1);
    }

    if (deStories.length < 1) {
      deStories = storiesArray;
    }


});

// DROP DOWN LIST OF ALL USER STORIES ON CLICK
var open = false;

var FullStory = function(story, id, upvoteSize) {
  this.story = story;
  this.id = id;
  this.upvoteSize = upvoteSize;
}

function formatter(arg) {
  return arg.story + '<br>' + "<a href='/stories/" + arg.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + arg.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'>upvotes: " + arg.upvoteSize + '</p><br><br>'
}

//$(document).on('click', '#view-all-button', function() {
$('#view-all-button').unbind('click').on('click', function() {
  if (open == false) {
    $.get('/users/' + user + '/stories.json', function(data) {

      for (var i=0;i<data.length;i++) {
        var story = new FullStory(data[i].full_story, data[i].id, data[i].upvotes.length);
        $('#story-list').append(formatter(story));
    };
    open = true;
  });

  } else if (open == true) {
      $('#story-list').html('');
      open = false;
    }
  });
});
