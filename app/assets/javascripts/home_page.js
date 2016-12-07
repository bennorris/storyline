var getUserId = function() {
  $.get('/get_id.json', function(res) {
     return res;
  })
}

var addStory = function() {
  $.get('/stories.json', function(data) {
    var currentUser = getUserId();
    var stories = Object.keys(data)
    var selected = data[stories[stories.length * Math.random() << 0]];
    $('#story-beginning').html(selected.beginning);
    $('#contributors-and-more').attr('href', `/stories/${selected.id}`);
    $('#full-story-button').attr('val', selected.id);
    var recentSentence = selected.sentences[selected.sentences.length-1]
     if (recentSentence && recentSentence.user_id == currentUser ) {
       $('#sentence-adder').html('<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>')
     } else {
       $('#sentence-adder').html("<a href='/stories/"+ selected.id + "'>Add a sentence</a>");
     }
   })

   clicked = false;
   $('#full-story-button').text('see full story');
}

var clicked = false;

var displayFullStory = function() {
  var id = $('#full-story-button').attr('val');
  $.get(`/stories/${id}.json`, function(data) {
    if (clicked === false ) {
    $('#story-beginning').html(data.full_story);
    $('#full-story-button').text('back to beginning');
    return clicked = !clicked;
  }
    $('#story-beginning').html(data.beginning);
    $('#full-story-button').text('see full story');
    clicked = !clicked;
 })
}

var open = false;

var displayAllStories = function() {
  if (open === false) {
    return $.get('/users/' + user + '/stories.json', function(data) {
              for (var i = 0; i < data.length; i++) {
                var story = new Story(data[i]);
                story.appendToDom();
              };
              return open = !open;
            });
  }
  $('#story-list').html('');
  open = !open;

  }

var Story = function(story) {
  this.full_story = story.full_story;
  this.id = story.id;
  this.upvotes = story.upvotes.length;
}

Story.prototype.appendToDom = function() {
  $('#story-list').append(
    this.full_story + '<br>' + "<a href='/stories/" + this.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + this.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'>upvotes: " + this.upvotes + '</p><br><br>'
  );
}



$(function() {
  addStory();

  $('#next-button').unbind('click').on('click', function() {
    addStory();
  });

  $('#view-all-button').unbind('click').on('click', function() {
    displayAllStories();
  });

  $('#full-story-button').unbind('click').on('click', function() {
    displayFullStory();
  });

})
