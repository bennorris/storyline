$(function() {

// SCROLLING THROUGH ALL STORIES

$('#next-button').on('click', function() {
//$(document).on('click', '#next-button', function() {
    $('#story-preview').empty();

    var rand = storiesArray[Math.floor(Math.random() * storiesArray.length)];
    if (rand[2] == false) {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><a href="/stories/'+rand[1]+'/sentences/new">Add a Sentence</a>'+
        '<a href="/stories/'+rand[1]+'">see contributors & more</a><br><br>');
    } else {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p>'+
        '<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>' +
        '<a href="/stories/'+rand[1]+'">see contributors & more</a><br><br>');
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
