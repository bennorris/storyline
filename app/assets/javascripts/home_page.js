$(function() {

// SCROLLING THROUGH ALL STORIES
$(document).on('click', '#next-button', function() {
    $('#story-preview').empty();

    var rand = storiesArray[Math.floor(Math.random() * storiesArray.length)];
    if (rand[2] == false) {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><br><a href="/stories/'+rand[1]+'/sentences/new">Add a Sentence</a><br></br>'+
        '<a href="/stories/'+rand[1]+'">see contributors & more</a>');
    } else {
      $('#story-preview').append(
        '<p>'+rand[0]+'</p><br>'+
        '<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p><br>' +
        '<a href="/stories/'+rand[1]+'">see contributors & more</a>');
    }
});

// DROP DOWN LIST OF ALL USER STORIES ON CLICK

var FullStory = function(story, id, upvoteSize) {
  this.story = story;
  this.id = id;
  this.upvoteSize = upvoteSize;
}

function formatter(arg) {
  return arg.story + '<br>' + "<a href='/stories/" + arg.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + arg.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'>upvotes: " + arg.upvoteSize + '</p><br><br>'
}

  var open = false;
  $('#view-all-button').on('click', function() {
    if (open == false) {
    $.get('/users/' + user + '/stories.json', function(data) {
      for (var i=0;i<data.length;i++) {
        var story = new FullStory(data[i].full_story, data[i].id, data[i].upvotes.length)
        $('#story-list').append(formatter(story));

    };
  });
    open = true;
  } else if (open == true) {
      $('#story-list').html('');
      open = false;
    }
  });
});
