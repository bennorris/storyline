////Grab User Id /////
var currentUser;

var getUserId = function() {
  $.get('/get_id.json', function(res) {
     currentUser = res;
  })
}

///// All stories section //////
var clicked = false;

var addStory = function() {
  $.get('/all_stories.json', function(data) {
    var stories = Object.keys(data)
    var selected = data[stories[stories.length * Math.random() << 0]];
    $('#story-beginning').html(selected.beginning);
    $('#scroll-upvote').attr('class', selected.id);
    $('#scroll-upvote').prop('disabled', false);
    $('#contributors-and-more').attr('href', `/stories/${selected.id}`);
    $('#full-story-button').attr('val', selected.id);
    $('#full-story-button').attr('disabled', false);
    var recentSentence = selected.sentences[selected.sentences.length-1]
     if (recentSentence && recentSentence.user_id == currentUser ) {
        $('#sentence-adder').html('<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>');
     }
      else if (selected.sentences.length < 1 && selected.user_id == currentUser) {
        $('#sentence-adder').html('<p style="color: #EF9A9A">You were the most recent to contribute. You can add a new sentence after someone else has.</p>');
     }
      else {
        $('#sentence-adder').html("<a href='/stories/"+ selected.id + "'>Add a sentence</a>");
     }

     for (var i = 0; i < selected.upvotes.length; i++) {
       if (selected.upvotes[i].user_id == currentUser)
        $('#scroll-upvote').addClass('just-clicked');
        $('#scroll-upvote').attr('disabled', true);
     }

     if (selected.sentences.length < 1) {
       $('#full-story-button').addClass('only-one');
       $('#full-story-button').attr('disabled', true);
       $('#full-story-button').text('one sentence so far');
     }
     else {
       $('#full-story-button').text('see full story');
       $('#full-story-button').attr('disabled', false);
       $('#full-story-button').removeClass('only-one');
     }
   })

   clicked = false;
   $('#upvote-success').text('');
}

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

////// Your Stories Section   ///////

 var idCount = 0;

 function getUserStory() {
   $.get('/users/' + currentUser + '.json', function(data) {
     $('#user-story-full').text(data[idCount].beginning);
     $('a#next-user-story').attr('href', '/stories/' + data[idCount].id);
     $('#delete-your-story').attr('href', '/stories/' + data[idCount].id);
     if (idCount < data.length - 1) {
       idCount+=1;
   } else {
       idCount = 0;
    }
   })
 }

 var open = false;

 var displayAllStories = function() {
   if (open === false) {
     return $.get('/users/' + currentUser + '/stories.json', function(data) {
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
   this.upvotesTotal = story.upvotes.length;
   this.userVotes = story.upvotes;
 }

 Story.prototype.appendToDom = function() {
   var showThumb = true;

   for (var i = 0; i < this.userVotes.length; i++) {
     if (this.userVotes[i].user_id.to_i == currentUser.to_i) {
         showThumb = false;
     }
   }

   if (showThumb == false) {
      $('#story-list').append(
        this.full_story + '<br>' + "<a href='/stories/" + this.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + this.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'><button id='thumbs' class='thumb-clicked " + this.id + "'><i class='fa fa-thumbs-up' aria-hidden='true'></i></button>&nbsp;&nbsp|&nbsp;&nbsp;upvotes: <span class='" + this.id + "'>" + this.upvotesTotal + '</span></p><br><br>'
      );
    }
    else {
    $('#story-list').append(
      this.full_story + '<br>' + "<a href='/stories/" + this.id + "'>details</a>" + "&nbsp;&nbsp;|&nbsp;&nbsp<a href='/stories/" + this.id + "' data-method='delete' data-confirm='Are you sure you want to delete this?'>delete</a>&nbsp&nbsp<p style='font-size:20px;color:#0D47A1'><button id='thumbs' class='" + this.id + "'><i class='fa fa-thumbs-up' aria-hidden='true'></i></button>&nbsp;&nbsp|&nbsp;&nbsp;upvotes: <span class='" + this.id + "'>" + this.upvotesTotal + '</span></p><br><br>');
    }
    showThumb = true;
}


///// Your Contributions Section //////

var sentenceCount = 0;

var displayContribution = function() {
  $.get('/users/' + currentUser + '/sentences.json', function(res) {
    $('#your-sentence-content').text(res[sentenceCount].content);
    $('#full-story-link').attr('href', `/stories/${res[sentenceCount].story_id}`);
    $('#delete-sentence').attr('href', `/stories/${res[sentenceCount].story_id}/sentences/${res[sentenceCount].id}`)
    if (sentenceCount < res.length - 1 ) {
      return sentenceCount += 1
    }
    sentenceCount = 0;
  })
}


/////////  UPVOTES /////////

var addScrollUpvote = function(btn) {
    var storyId = $(btn).attr('class');
    var upvote = new Upvote(storyId);
    upvote.addToScrollUpvote();

  }

var addUpvote = function(btn) {
  var storyId = $(btn).attr('class');
  var upvote = new Upvote(storyId);
  upvote.addToListUpvote();
  }

  var Upvote = function(story) {
    this.user_id = currentUser;
    this.upvotable_id = story
  }

  Upvote.prototype.addToScrollUpvote = function() {
    var val = {user_id: this.user_id, upvotable_id: this.upvotable_id};
    $.post(`/stories/${this.upvotable_id}/upvotes`, val)
       .done(function() {
          $('#upvote-success').text("Thanks for your upvote!");
          $('#scroll-upvote').addClass('just-clicked');
          $('#scroll-upvote').attr('disabled', true);
      })
      .fail(function(error) {
        console.log(error);
      });
  }

  Upvote.prototype.addToListUpvote = function() {
    var storyId = this.upvotable_id
    $(`button#thumbs.${storyId}`).prop('disabled', true);
    $(`button#thumbs.${storyId}`).addClass('thumb-clicked');
    var val = {user_id: this.user_id, upvotable_id: this.upvotable_id};
    $.post(`/stories/${storyId}/upvotes`, val)
      .done(function(data) {
        $(`span.${storyId}`).text(data.upvotes.length);
      })
}


/////// RUN !! //////
$(function() {
  getUserId();
  addStory();
  getUserStory();
  displayContribution();


  $('#next-button').unbind('click').on('click', function() {
    addStory();
  });

  $('#view-all-button').unbind('click').on('click', function() {
    displayAllStories();
  });

  $('#full-story-button').unbind('click').on('click', function() {
    displayFullStory();
  });

  $('#your-stories-button').unbind('click').on('click' , function(e) {
      e.stopImmediatePropagation();
      getUserStory();
    });

  $('#your-sentences-button').unbind('click').on('click', function(e) {
    e.stopImmediatePropagation();
    displayContribution();
    });

  $(document).on('click', '#thumbs', function(e)  {
      e.stopImmediatePropagation();
      e.preventDefault();
      addUpvote($(this));
    });

    $(document).on('click', '#scroll-upvote', function(e)  {
        e.stopImmediatePropagation();
        e.preventDefault();
        addScrollUpvote($(this));
      })

})
